import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class NombreEleve extends StatefulWidget {
  //
  const NombreEleve({Key? key}) : super(key: key);

  @override
  _NombreEleve createState() => _NombreEleve();
}

class _NombreEleve extends State<NombreEleve> {
  late List<_ChartData> data;
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    data = [
      _ChartData('David', 25),
      _ChartData('Steve', 38),
      _ChartData('Jack', 34),
      _ChartData('Others', 52)
    ];
    data = [
      _ChartData("Bas-Uele", 225),
      _ChartData("Equateur", 2445),
      _ChartData("Haut-Katanga", 245),
      _ChartData("Haut-Lomami", 2115),
      _ChartData("Ituri", 2775),
      _ChartData("Kasai", 2995),
      _ChartData("Kasai central", 2905),
      _ChartData("Kasai oriental", 2335),
      _ChartData("Kinshasa", 259),
      _ChartData("Kongo Central", 3325),
      _ChartData("Kwango", 25245),
      _ChartData("Kwilu", 2599),
      _ChartData("Lomami", 2588),
      _ChartData("Lualaba", 2615),
      _ChartData("Mai-Ndombe", 3825),
      _ChartData("Maniema", 1205),
      _ChartData("Mongala", 1983),
      _ChartData("Nord-Kivu", 2387),
      _ChartData("Nord-Ubangi", 1953),
      _ChartData("Sankuru", 2839),
      _ChartData("Sud-Kivu", 1290),
      _ChartData("Sud-Ubangi", 12993),
      _ChartData("Tanganyika", 23789),
      _ChartData("Tshopo", 33088),
      _ChartData("Tshuapa", 19980),
    ];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Nombre d'élèves"),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SfCircularChart(
              tooltipBehavior: _tooltip,
              series: <CircularSeries<_ChartData, String>>[
                DoughnutSeries<_ChartData, String>(
                  dataSource: data,
                  xValueMapper: (_ChartData data, _) => data.x,
                  yValueMapper: (_ChartData data, _) => data.y,
                  dataLabelMapper: (_ChartData data, _) => data.x,
                  dataLabelSettings: const DataLabelSettings(
                    margin: EdgeInsets.all(0),
                    useSeriesColor: true,
                    isVisible: true,
                    overflowMode: OverflowMode.none,
                    labelPosition: ChartDataLabelPosition.inside,
                    labelAlignment: ChartDataLabelAlignment.middle,
                    showCumulativeValues: true,
                    color: Colors.black,
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                  radius: "120",
                  name: 'Gold',
                ),
              ],
            ),
          ],
        ));
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}
