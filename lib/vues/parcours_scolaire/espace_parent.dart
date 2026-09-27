import 'dart:convert';

import 'package:epst_app/utils/connexion.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

/// Onglet "Parcours scolaire" de l'espace élève.
///
/// Un parent pouvant gérer plusieurs enfants, on affiche d'abord la liste des
/// élèves enregistrés. La page d'accueil (actions) n'apparaît qu'après la
/// sélection d'un élève.
class EspaceParent extends StatefulWidget {
  const EspaceParent({super.key});

  @override
  State<EspaceParent> createState() => _EspaceParentState();
}

class _EspaceParentState extends State<EspaceParent> {
  final GetStorage box = GetStorage();
  final RxList<Map> eleves = <Map>[].obs;

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loadEleves();
  }

  void _loadEleves() {
    final List data = box.read("eleves") ?? [];
    eleves.assignAll(
      data
          .whereType<Map>()
          .map((e) => Map<String, dynamic>.from(e))
          .toList(),
    );
  }

  Future<void> _persist() async {
    await box.write("eleves", eleves.toList());
  }

  String _nomComplet(Map e) {
    final parts = [e['nom'], e['postnom'], e['prenom']]
        .where((p) => p != null && '$p'.trim().isNotEmpty)
        .map((p) => '$p'.trim());
    return parts.isEmpty ? "Élève" : parts.join(" ");
  }

  void _showAddEleveDialog() {
    final TextEditingController code = TextEditingController();
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text("Ajouter un élève"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Saisissez le matricule (identifiant) remis par l'école.",
                style: TextStyle(fontSize: 13),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: code,
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: "Identifiant élève",
                  prefixIcon: Icon(Icons.badge_outlined),
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text("Annuler"),
            ),
            ElevatedButton(
              onPressed: () {
                final value = code.text.trim();
                if (value.isEmpty) return;
                Navigator.of(dialogContext).pop();
                _fetchEleve(value);
              },
              child: const Text("Rechercher"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _fetchEleve(String identifiant) async {
    setState(() => _loading = true);
    try {
      final url = Uri.parse(
        "${Connexion.lien2}eleve/numeroIdentifiant/${Uri.encodeComponent(identifiant)}",
      );
      final response = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
      );
      if (!mounted) return;
      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        Map? eleve;
        if (decoded is Map) {
          eleve = Map<String, dynamic>.from(decoded);
        } else if (decoded is List &&
            decoded.isNotEmpty &&
            decoded.first is Map) {
          eleve = Map<String, dynamic>.from(decoded.first as Map);
        }
        if (eleve == null) {
          _showMessage("Aucun élève trouvé pour ce matricule.");
          return;
        }
        final Map data = eleve;
        final bool exist = eleves.any(
          (e) =>
              '${e['numeroIdentifiant']}' == '${data['numeroIdentifiant']}' &&
              '${e['anneescolaire']}' == '${data['anneescolaire']}',
        );
        if (exist) {
          _showMessage("Cet élève est déjà enregistré.");
          return;
        }
        eleves.add(data);
        await _persist();
        _showMessage("Élève ajouté avec succès.");
      } else if (response.statusCode == 404) {
        _showMessage("Élève introuvable. Vérifiez le matricule.");
      } else {
        _showMessage("Erreur: ${response.statusCode}");
      }
    } catch (e) {
      if (mounted) {
        _showMessage("Connexion impossible. Vérifiez votre réseau.");
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> _confirmRemove(Map eleve) async {
    final bool? ok = await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: const Text("Retirer cet élève ?"),
        content: Text(_nomComplet(eleve)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(c).pop(false),
            child: const Text("Annuler"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(c).pop(true),
            child: const Text("Retirer"),
          ),
        ],
      ),
    );
    if (ok != true) return;
    eleves.remove(eleve);
    await _persist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (eleves.isEmpty) {
          return _emptyState();
        }
        return Column(
          children: [
            _header(),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: eleves.length,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final Map eleve = eleves[index];
                  return Card(
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue.shade100,
                        child: Icon(
                          Icons.school_rounded,
                          color: Colors.blue.shade700,
                        ),
                      ),
                      title: Text(
                        _nomComplet(eleve),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      subtitle: Text(
                        "${eleve['classe'] ?? ''}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blue.shade700,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        Get.to(() => EspaceEleve(eleve: eleve));
                      },
                      onLongPress: () => _confirmRemove(eleve),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _loading ? null : _showAddEleveDialog,
        icon: _loading
            ? const SizedBox(
                height: 18,
                width: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : const Icon(Icons.person_add_alt),
        label: const Text("Ajouter un élève"),
      ),
    );
  }

  Widget _header() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      color: Colors.grey.shade100,
      child: Column(
        children: [
          Image.asset(
            "assets/logo_min_edu_nc.png",
            height: 60,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 6),
          const Text(
            "Mes élèves",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const Text(
            "Sélectionnez un enfant pour suivre sa scolarité",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _emptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/logo_min_edu_nc.png",
              height: 120,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 16),
            const Text(
              "Aucun élève enregistré",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Ajoutez le matricule de votre enfant pour suivre son évolution "
              "tout au long de sa scolarité.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _loading ? null : _showAddEleveDialog,
              icon: const Icon(Icons.person_add_alt),
              label: const Text("Ajouter un élève"),
            ),
          ],
        ),
      ),
    );
  }
}

/// Tableau de bord d'un élève sélectionné.
class EspaceEleve extends StatelessWidget {
  final Map eleve;
  const EspaceEleve({super.key, required this.eleve});

  String get _nomComplet {
    final parts = [eleve['nom'], eleve['postnom'], eleve['prenom']]
        .where((p) => p != null && '$p'.trim().isNotEmpty)
        .map((p) => '$p'.trim());
    return parts.isEmpty ? "Élève" : parts.join(" ");
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, Object>> actions = [
      {"titre": "Suivi scolaire", "icone": Icons.timeline_outlined},
      {"titre": "Résultats", "icone": Icons.school_outlined},
      {"titre": "Présence", "icone": Icons.fact_check_outlined},
      {"titre": "Paiements", "icone": Icons.receipt_long_outlined},
      {"titre": "Messages école", "icone": Icons.mail_outline},
      {"titre": "Documents", "icone": Icons.folder_open_outlined},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Espace élève"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Image.asset(
                  "assets/logo_min_edu_nc.png",
                  height: 48,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _nomComplet,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${eleve['classe'] ?? ''}",
                        style: const TextStyle(fontSize: 12),
                      ),
                      if ('${eleve['anneescolaire'] ?? ''}'.isNotEmpty)
                        Text(
                          "Année ${eleve['anneescolaire']}",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1.1,
            children: List.generate(actions.length, (index) {
              final Map<String, Object> action = actions[index];
              return Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "${action["titre"]} — bientôt disponible",
                        ),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        action["icone"] as IconData,
                        size: 38,
                        color: Colors.blue,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "${action["titre"]}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
