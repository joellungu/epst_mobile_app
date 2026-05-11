import 'package:epst_app/vues/ministre/linistre_controller.dart';
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
          builder: (_) => EntityDetailSheet(detail: detail),
        );
      },
    );
  }
}

class EntityDetailSheet extends StatelessWidget {
  final Map<String, dynamic> detail;

  const EntityDetailSheet({Key? key, required this.detail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

IconData entityIcon(String type) {
  if (type == 'teachers') {
    return Icons.groups_outlined;
  }
  if (type == 'admin') {
    return Icons.badge_outlined;
  }
  return Icons.school_outlined;
}

