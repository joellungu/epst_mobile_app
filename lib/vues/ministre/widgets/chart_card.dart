import 'package:epst_app/vues/ministre/linistre_controller.dart';
import 'package:epst_app/vues/ministre/widgets/ministre_common.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

enum MinistreChartKind { bar, doughnut, ranking }

class MinistreChartCard extends StatelessWidget {
  final AnalyticsChart? chart;
  final MinistreChartKind chartKind;

  const MinistreChartCard({
    Key? key,
    required this.chart,
    required this.chartKind,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = chart;
    final effectiveKind = chartKind == MinistreChartKind.bar &&
            data != null &&
            data.points.length > 8
        ? MinistreChartKind.ranking
        : chartKind;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
      decoration: ministreBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data?.title.isNotEmpty == true ? data!.title : 'Statistique',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color(0xFF172033),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: _chartHeight(effectiveKind, data),
            child: data == null || data.isEmpty
                ? const Center(
                    child: Text(
                      'Aucune donnee disponible',
                      style: TextStyle(color: Color(0xFF607089)),
                    ),
                  )
                : effectiveKind == MinistreChartKind.doughnut
                    ? _DoughnutChart(chart: data)
                    : effectiveKind == MinistreChartKind.ranking
                        ? _RankingChart(chart: data)
                        : _BarChart(chart: data),
          ),
        ],
      ),
    );
  }

  double _chartHeight(MinistreChartKind kind, AnalyticsChart? data) {
    if (kind == MinistreChartKind.doughnut) {
      return 250;
    }
    if (kind == MinistreChartKind.ranking) {
      final count = data?.points.length ?? 0;
      return (count * 54.0).clamp(220.0, 520.0).toDouble();
    }
    return 300;
  }
}

class _BarChart extends StatelessWidget {
  final AnalyticsChart chart;

  const _BarChart({Key? key, required this.chart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: CategoryAxis(
        labelRotation: -35,
        labelStyle: const TextStyle(fontSize: 10),
        majorGridLines: const MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
        labelFormat: chart.unit == 'pourcentage' ? '{value}%' : '{value}',
        majorGridLines: const MajorGridLines(width: 0.4),
      ),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <CartesianSeries<AnalyticsPoint, String>>[
        ColumnSeries<AnalyticsPoint, String>(
          dataSource: chart.points,
          xValueMapper: (point, _) => point.label,
          yValueMapper: (point, _) => point.value,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
          color: const Color(0xFF2454A6),
          dataLabelSettings: const DataLabelSettings(isVisible: true),
        ),
      ],
    );
  }
}

class _DoughnutChart extends StatelessWidget {
  final AnalyticsChart chart;

  const _DoughnutChart({Key? key, required this.chart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      legend: Legend(
        isVisible: true,
        overflowMode: LegendItemOverflowMode.wrap,
        position: LegendPosition.bottom,
      ),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <CircularSeries<AnalyticsPoint, String>>[
        DoughnutSeries<AnalyticsPoint, String>(
          dataSource: chart.points,
          xValueMapper: (point, _) => point.label,
          yValueMapper: (point, _) => point.value,
          dataLabelMapper: (point, _) =>
              '${point.label}: ${formatAnalyticsNumber(point.value)}',
          dataLabelSettings: const DataLabelSettings(isVisible: true),
          innerRadius: '62%',
        ),
      ],
    );
  }
}

class _RankingChart extends StatelessWidget {
  final AnalyticsChart chart;

  const _RankingChart({Key? key, required this.chart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final points = chart.points.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final maxValue = points.fold<double>(
      0,
      (max, point) => point.value > max ? point.value : max,
    );
    return ListView.separated(
      physics: const ClampingScrollPhysics(),
      itemCount: points.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final point = points[index];
        final ratio = maxValue <= 0 ? 0.0 : point.value / maxValue;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    point.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF172033),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  chart.unit == 'pourcentage'
                      ? '${formatAnalyticsNumber(point.value)}%'
                      : formatAnalyticsNumber(point.value),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2454A6),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: ratio.clamp(0.0, 1.0).toDouble(),
                minHeight: 8,
                backgroundColor: const Color(0xFFE7EEF9),
                valueColor:
                    const AlwaysStoppedAnimation<Color>(Color(0xFF2454A6)),
              ),
            ),
          ],
        );
      },
    );
  }
}
