import 'package:epst_app/vues/bibliotheques/models/bibliotheque_classe.dart';
import 'package:epst_app/vues/bibliotheques/pages/bibliotheque_cours_page.dart';
import 'package:epst_app/vues/bibliotheques/services/bibliotheque_service.dart';
import 'package:epst_app/vues/bibliotheques/widgets/bibliotheque_empty_state.dart';
import 'package:epst_app/vues/bibliotheques/widgets/bibliotheque_status_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BibliothequeClassesPage extends StatefulWidget {
  final String propriete;

  const BibliothequeClassesPage({
    Key? key,
    required this.propriete,
  }) : super(key: key);

  @override
  State<BibliothequeClassesPage> createState() =>
      _BibliothequeClassesPageState();
}

class _BibliothequeClassesPageState extends State<BibliothequeClassesPage> {
  final BibliothequeService _service = BibliothequeService();

  late Future<List<BibliothequeClasse>> _future;
  bool _connected = false;

  @override
  void initState() {
    super.initState();
    _future = _load();
  }

  Future<List<BibliothequeClasse>> _load({bool refresh = false}) async {
    _connected = await _service.isConnected();
    final classes = await _service.getClasses(
      widget.propriete,
      refresh: refresh,
    );
    if (mounted) {
      setState(() {});
    }
    return classes;
  }

  Future<void> _refresh() async {
    setState(() {
      _future = _load(refresh: true);
    });
    await _future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      body: SafeArea(
        child: FutureBuilder<List<BibliothequeClasse>>(
          future: _future,
          builder: (context, snapshot) {
            final classes = snapshot.data ?? [];

            return RefreshIndicator(
              onRefresh: _refresh,
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(18, 18, 18, 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Bibliothèque',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF14213D),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '${widget.propriete} - classes et cours disponibles hors connexion après téléchargement.',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade700,
                            ),
                          ),
                          const SizedBox(height: 14),
                          BibliothequeStatusBar(
                            connected: _connected,
                            lastUpdateLabel: _service.lastUpdateLabel,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (snapshot.connectionState == ConnectionState.waiting &&
                      classes.isEmpty)
                    const SliverFillRemaining(
                      child: Center(child: CircularProgressIndicator()),
                    )
                  else if (classes.isEmpty)
                    const SliverFillRemaining(
                      child: BibliothequeEmptyState(
                        icon: Icons.menu_book_outlined,
                        title: 'Aucune classe enregistrée',
                        message:
                            'Connectez-vous puis tirez vers le bas pour synchroniser la bibliothèque.',
                      ),
                    )
                  else
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(14, 8, 14, 24),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => _ClasseTile(
                            classe: classes[index],
                            onTap: () {
                              Get.to(
                                BibliothequeCoursPage(
                                  classe: classes[index],
                                  service: _service,
                                  propriete: widget.propriete,
                                ),
                              );
                            },
                          ),
                          childCount: classes.length,
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ClasseTile extends StatelessWidget {
  final BibliothequeClasse classe;
  final VoidCallback onTap;

  const _ClasseTile({
    Key? key,
    required this.classe,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final details = classe.detailsLabel;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        leading: Container(
          height: 44,
          width: 44,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            classe.shortLabel,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.w800,
              fontSize: 12,
            ),
          ),
        ),
        title: Text(
          classe.displayName,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            color: Color(0xFF14213D),
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            details.isEmpty
                ? '${classe.totalCours} fichier${classe.totalCours > 1 ? 's' : ''}'
                : '$details\n${classe.totalCours} fichier${classe.totalCours > 1 ? 's' : ''}',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
