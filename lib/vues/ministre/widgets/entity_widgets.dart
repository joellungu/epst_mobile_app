import 'package:epst_app/utils/connexion.dart';
import 'package:epst_app/vues/ministre/linistre_controller.dart';
import 'package:epst_app/vues/ministre/widgets/ministre_common.dart';
import 'package:flutter/material.dart';

class EntityTile extends StatelessWidget {
  final MinistreController controller;
  final EntityListItem item;
  final String? entityType;

  const EntityTile({
    Key? key,
    required this.controller,
    required this.item,
    this.entityType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final type = entityType ?? controller.explorerType.value;
    final subtitle = [
      if (item.classe.isNotEmpty) item.classe,
      if (item.typeEnseignant.isNotEmpty) item.typeEnseignant,
      if (item.fonction.isNotEmpty) item.fonction,
      if (item.nomEcole.isNotEmpty) item.nomEcole,
    ].join(' | ');
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: const Color(0xFFE7EEF9),
        child: Icon(entityIcon(type), color: const Color(0xFF2454A6)),
      ),
      title: Text(
        item.fullName.isEmpty ? item.numeroIdentifiant : item.fullName,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        subtitle.isEmpty ? '${item.province} ${item.ville}' : subtitle,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: () async {
        final detail = await controller.loadEntityDetail(item, type: type);
        if (!context.mounted) {
          return;
        }
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (_) => EntityDetailSheet(detail: detail, entityType: type),
        );
      },
    );
  }
}

class EntityDetailSheet extends StatelessWidget {
  final Map<String, dynamic> detail;
  final String entityType;

  const EntityDetailSheet({
    Key? key,
    required this.detail,
    required this.entityType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (entityType == 'students') {
      return _StudentDetailSheet(detail: detail);
    }
    final entries = detail.entries
        .where((entry) => entry.value != null && '${entry.value}'.isNotEmpty)
        .toList();
    return SafeArea(
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.72,
        maxChildSize: 0.92,
        minChildSize: 0.35,
        builder: (context, scrollController) {
          return ListView(
            controller: scrollController,
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                '${detail['fullName'] ?? 'Detail'}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 12),
              ...entries.map(
                (entry) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 145,
                        child: Text(
                          entry.key,
                          style: const TextStyle(
                            color: Color(0xFF607089),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Expanded(child: Text('${entry.value}')),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _StudentDetailSheet extends StatelessWidget {
  final Map<String, dynamic> detail;

  const _StudentDetailSheet({Key? key, required this.detail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.82,
        maxChildSize: 0.95,
        minChildSize: 0.45,
        builder: (context, scrollController) {
          return ListView(
            controller: scrollController,
            padding: const EdgeInsets.all(16),
            children: [
              _StudentHeader(detail: detail),
              const SizedBox(height: 12),
              _StudentStats(detail: detail),
              const SizedBox(height: 12),
              _DetailSection(
                title: 'Identite',
                children: [
                  _DetailLine('Nom', _text('nom')),
                  _DetailLine('Postnom', _text('postnom')),
                  _DetailLine('Prenom', _text('prenom')),
                  _DetailLine('Sexe', _text('sexe')),
                  _DetailLine('Date de naissance', _text('dateNaissance')),
                  _DetailLine('Lieu de naissance', _text('lieuNaissance')),
                  _DetailLine('Identifiant', _text('numeroIdentifiant')),
                ],
              ),
              const SizedBox(height: 12),
              _DetailSection(
                title: 'Scolarite',
                children: [
                  _DetailLine('Classe', _text('classe')),
                  _DetailLine('Annee scolaire', _text('anneescolaire')),
                  _DetailLine('Ecole', _text('nomEcole')),
                  _DetailLine('Province', _text('province')),
                  _DetailLine('Ville', _text('ville')),
                  _DetailLine('Cle ecole', _text('cleEcole')),
                ],
              ),
              const SizedBox(height: 12),
              _DetailSection(
                title: 'Suivi',
                children: [
                  _DetailLine('Notes encodees', _text('notesCount')),
                  _DetailLine('Presences encodees', _text('presencesCount')),
                  _DetailLine('Paiements', _text('paymentsCount')),
                  _DetailLine('Total paye', _money('paymentsTotal')),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  String _text(String key) {
    final value = detail[key];
    if (value == null || '$value'.trim().isEmpty) {
      return '-';
    }
    return '$value';
  }

  String _money(String key) {
    final value = detail[key];
    if (value is num) {
      return formatAnalyticsNumber(value.toDouble());
    }
    final parsed = double.tryParse('${value ?? ''}');
    if (parsed == null) {
      return '-';
    }
    return formatAnalyticsNumber(parsed);
  }
}

class _StudentHeader extends StatelessWidget {
  final Map<String, dynamic> detail;

  const _StudentHeader({Key? key, required this.detail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final name = _value('fullName').isEmpty ? 'Eleve' : _value('fullName');
    final identifier = _value('numeroIdentifiant');
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: ministreBoxDecoration(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _StudentPhoto(numeroIdentifiant: identifier),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF172033),
                  ),
                ),
                const SizedBox(height: 6),
                _BadgeText(icon: Icons.badge_outlined, text: identifier),
                _BadgeText(icon: Icons.school_outlined, text: _value('classe')),
                _BadgeText(
                  icon: Icons.apartment_outlined,
                  text: _value('nomEcole'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _value(String key) {
    final value = detail[key];
    return value == null ? '' : '$value';
  }
}

class _StudentPhoto extends StatelessWidget {
  final String numeroIdentifiant;

  const _StudentPhoto({Key? key, required this.numeroIdentifiant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hasIdentifier = numeroIdentifiant.trim().isNotEmpty;
    final url =
        '${Connexion.lien2.replaceAll(RegExp(r"/+$"), "")}/eleve/${Uri.encodeComponent(numeroIdentifiant)}/download-photo';
        print('Photo URL: $url');
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 86,
        height: 104,
        color: const Color(0xFFE7EEF9),
        child: hasIdentifier
            ? Image.network(
                url,
                fit: BoxFit.fill,
                errorBuilder: (_, __, ___) => const _PhotoFallback(),
                loadingBuilder: (context, child, progress) {
                  if (progress == null) {
                    return child;
                  }
                  return const Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  );
                },
              )
            : const _PhotoFallback(),
      ),
    );
  }
}

class _PhotoFallback extends StatelessWidget {
  const _PhotoFallback();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(Icons.person, color: Color(0xFF2454A6), size: 42),
    );
  }
}

class _BadgeText extends StatelessWidget {
  final IconData icon;
  final String text;

  const _BadgeText({Key? key, required this.icon, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (text.trim().isEmpty) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        children: [
          Icon(icon, size: 15, color: const Color(0xFF607089)),
          const SizedBox(width: 5),
          Expanded(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Color(0xFF607089), fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

class _StudentStats extends StatelessWidget {
  final Map<String, dynamic> detail;

  const _StudentStats({Key? key, required this.detail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = [
      _StatItem('Moyenne', _number('averageScore'), Icons.analytics_outlined),
      _StatItem('Reussite', '${_number('successRate')}%',
          Icons.trending_up_outlined),
      _StatItem(
          'Presence', '${_number('presenceRate')}%', Icons.check_circle_outline),
    ];
    return Row(
      children: items
          .map(
            (item) => Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: _StatCard(item: item),
              ),
            ),
          )
          .toList(),
    );
  }

  String _number(String key) {
    final value = detail[key];
    if (value is num) {
      return formatAnalyticsNumber(value.toDouble());
    }
    final parsed = double.tryParse('${value ?? ''}');
    if (parsed == null) {
      return '0';
    }
    return formatAnalyticsNumber(parsed);
  }
}

class _StatItem {
  final String label;
  final String value;
  final IconData icon;

  _StatItem(this.label, this.value, this.icon);
}

class _StatCard extends StatelessWidget {
  final _StatItem item;

  const _StatCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: ministreBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(item.icon, color: const Color(0xFF2454A6), size: 20),
          const SizedBox(height: 8),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              item.value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Color(0xFF172033),
              ),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            item.label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Color(0xFF607089), fontSize: 11),
          ),
        ],
      ),
    );
  }
}

class _DetailSection extends StatelessWidget {
  final String title;
  final List<_DetailLine> children;

  const _DetailSection({Key? key, required this.title, required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: ministreBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: Color(0xFF172033),
            ),
          ),
          const SizedBox(height: 8),
          ...children,
        ],
      ),
    );
  }
}

class _DetailLine extends StatelessWidget {
  final String label;
  final String value;

  const _DetailLine(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xFF607089),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Color(0xFF172033),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

IconData entityIcon(String type) {
  if (type == 'teachers') {
    return Icons.groups_outlined;
  }
  if (type == 'admin') {
    return Icons.badge_outlined;
  }
  return Icons.school_outlined;
}
