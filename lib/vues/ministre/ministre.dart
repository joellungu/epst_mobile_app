import 'package:epst_app/vues/ministre/linistre_controller.dart';
import 'package:epst_app/vues/ministre/widgets/chart_card.dart';
import 'package:epst_app/vues/ministre/widgets/error_banner.dart';
import 'package:epst_app/vues/ministre/widgets/explorer_panel.dart';
import 'package:epst_app/vues/ministre/widgets/filter_panel.dart';
import 'package:epst_app/vues/ministre/widgets/ministre_header.dart';
import 'package:epst_app/vues/ministre/widgets/section_title.dart';
import 'package:epst_app/vues/ministre/widgets/summary_grid.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Ministre extends GetView<MinistreController> {
  Ministre({Key? key}) : super(key: key) {
    if (!Get.isRegistered<MinistreController>()) {
      Get.put(MinistreController(), permanent: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        title: const Text("Tableau de bord de l'EPST"),
        actions: [
          IconButton(
            tooltip: 'Actualiser',
            onPressed: controller.loadAnalytics,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Obx(
        () {
          if (controller.loading.value && controller.summary.value == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return RefreshIndicator(
            onRefresh: controller.loadAnalytics,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),
              children: [
                MinistreHeader(controller: controller),
                if (controller.errorMessage.value.isNotEmpty)
                  MinistreErrorBanner(message: controller.errorMessage.value),
                const SizedBox(height: 12),
                MinistreFilterPanel(controller: controller),
                const SizedBox(height: 12),
                MinistreSummaryGrid(summary: controller.summary.value),
                const SizedBox(height: 18),
                MinistreExplorerPanel(controller: controller),
                const SizedBox(height: 18),
                const MinistreSectionTitle(
                  title: 'Eleves',
                  subtitle: 'Effectifs, parite, reussite et presence',
                ),
                MinistreChartCard(
                  chart: controller.charts['studentsByClass'],
                  chartKind: MinistreChartKind.ranking,
                ),
                MinistreChartCard(
                  chart: controller.charts['studentsBySex'],
                  chartKind: MinistreChartKind.doughnut,
                ),
                MinistreChartCard(
                  chart: controller.charts['studentSuccessBySex'],
                  chartKind: MinistreChartKind.bar,
                ),
                const SizedBox(height: 10),
                const MinistreSectionTitle(
                  title: 'Personnel',
                  subtitle: 'Enseignants et administration',
                ),
                MinistreChartCard(
                  chart: controller.charts['teachersByType'],
                  chartKind: MinistreChartKind.bar,
                ),
                MinistreChartCard(
                  chart: controller.charts['adminByFunction'],
                  chartKind: MinistreChartKind.bar,
                ),
                const SizedBox(height: 10),
                const MinistreSectionTitle(
                  title: 'Ecoles',
                  subtitle: 'Repartition geographique et effectifs',
                ),
                MinistreChartCard(
                  chart: controller.charts['schoolsByProvince'],
                  chartKind: MinistreChartKind.bar,
                ),
                MinistreChartCard(
                  chart: controller.charts['schoolEffectifs'],
                  chartKind: MinistreChartKind.ranking,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
