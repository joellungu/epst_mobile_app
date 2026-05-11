import 'package:epst_app/vues/ministre/linistre_controller.dart';
import 'package:epst_app/vues/ministre/widgets/ministre_common.dart';
import 'package:flutter/material.dart';

class MinistreSummaryGrid extends StatelessWidget {
  final AnalyticsSummary? summary;

  const MinistreSummaryGrid({Key? key, required this.summary})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = <_KpiItem>[
      _KpiItem('Eleves', summary?.students.total ?? 0, Icons.school_outlined),
      _KpiItem('Ecoles', summary?.schools.total ?? 0, Icons.apartment_outlined),
      _KpiItem(
          'Enseignants', summary?.teachers.total ?? 0, Icons.groups_outlined),
      _KpiItem(
          'Administration', summary?.admin.total ?? 0, Icons.badge_outlined),
      _KpiItem('Filles eleves', summary?.students.femalePercentage ?? 0,
          Icons.pie_chart_outline,
          suffix: '%'),
      _KpiItem('Reussite', summary?.students.successRate ?? 0,
          Icons.trending_up_outlined,
          suffix: '%'),
      _KpiItem('Presence eleves', summary?.students.presenceRate ?? 0,
          Icons.check_circle_outline,
          suffix: '%'),
      _KpiItem('Villes', summary?.schools.cities ?? 0, Icons.location_city),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 720 ? 4 : 2;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: columns == 4 ? 2.2 : 1.55,
          ),
          itemBuilder: (context, index) => _KpiCard(item: items[index]),
        );
      },
    );
  }
}

class _KpiItem {
  final String label;
  final double value;
  final IconData icon;
  final String suffix;

  _KpiItem(this.label, this.value, this.icon, {this.suffix = ''});
}

class _KpiCard extends StatelessWidget {
  final _KpiItem item;

  const _KpiCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: ministreBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(item.icon, color: const Color(0xFF2454A6), size: 23),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              '${formatAnalyticsNumber(item.value)}${item.suffix}',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: Color(0xFF172033),
              ),
            ),
          ),
          Text(
            item.label,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xFF607089),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

