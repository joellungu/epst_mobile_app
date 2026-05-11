import 'package:epst_app/main.dart';
import 'package:epst_app/vues/ministre/linistre_controller.dart';
import 'package:epst_app/vues/ministre/pages/entity_search_page.dart';
import 'package:epst_app/vues/ministre/widgets/chart_card.dart';
import 'package:epst_app/vues/ministre/widgets/ministre_common.dart';
import 'package:flutter/material.dart';

class MinistreExplorerPanel extends StatelessWidget {
  final MinistreController controller;

  const MinistreExplorerPanel({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: ministreBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Explorer les donnees',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Color(0xFF172033),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _activeFilterText(controller),
            style: const TextStyle(color: Color(0xFF607089), fontSize: 12),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            children: [
              _ExplorerChip(controller, 'students', 'Eleves'),
              _ExplorerChip(controller, 'teachers', 'Enseignants'),
              _ExplorerChip(controller, 'admin', 'Admin'),
            ],
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: OutlinedButton.icon(
              onPressed: () {
                controller.clearEntityResults();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => EntitySearchPage(
                      controller: controller,
                      initialType: controller.explorerType.value,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.search, size: 18),
              label: const Text('Rechercher une personne'),
            ),
          ),
          const SizedBox(height: 10),
          if (controller.explorerLoading.value)
            const Padding(
              padding: EdgeInsets.all(18),
              child: Center(child: CircularProgressIndicator()),
            )
          else if (controller.explorerCharts.isEmpty)
            const Padding(
              padding: EdgeInsets.all(18),
              child: Center(
                child: Text(
                  'Aucune statistique disponible pour ces filtres',
                  style: TextStyle(color: Color(0xFF607089)),
                ),
              ),
            )
          else
            Column(
              children: controller.explorerCharts.values
                  .map(
                    (chart) => MinistreChartCard(
                      chart: chart,
                      chartKind: chart.type == 'pie'
                          ? MinistreChartKind.doughnut
                          : MinistreChartKind.bar,
                    ),
                  )
                  .toList(),
            ),
        ],
      ),
    );
  }

  String _activeFilterText(MinistreController controller) {
    final parts = [
      if (controller.selectedProvince.value.isNotEmpty)
        controller.selectedProvince.value,
      if (controller.selectedVille.value.isNotEmpty)
        controller.selectedVille.value,
      if (controller.selectedEcoleName.value.isNotEmpty)
        controller.selectedEcoleName.value,
      if (annee.value.isNotEmpty) annee.value,
    ];
    return parts.isEmpty ? 'Vue globale' : parts.join(' / ');
  }
}

class _ExplorerChip extends StatelessWidget {
  final MinistreController controller;
  final String value;
  final String label;

  const _ExplorerChip(this.controller, this.value, this.label, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selected = controller.explorerType.value == value;
    return ChoiceChip(
      selected: selected,
      label: Text(label),
      onSelected: (_) => controller.changeExplorer(value),
    );
  }
}

