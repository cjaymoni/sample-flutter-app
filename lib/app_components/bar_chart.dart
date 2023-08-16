import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class BarChartSample extends StatelessWidget {
  final double furnitureData;
  final double accessoriesData;
  final double electronicsData;
  BarChartSample(
      {super.key,
      required this.furnitureData,
      required this.accessoriesData,
      required this.electronicsData});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 200,
      child: BarChart(BarChartData(
          titlesData: const FlTitlesData(
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles:
                  AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                      showTitles: true, getTitlesWidget: getBottomTitleData))),
          borderData: FlBorderData(
              border: const Border(
            top: BorderSide.none,
            right: BorderSide.none,
            left: BorderSide(width: 1),
            bottom: BorderSide(width: 1),
          )),
          groupsSpace: 10,
          gridData: FlGridData(show: false),

          //add bars
          barGroups: [
            BarChartGroupData(x: 1, barRods: [
              BarChartRodData(
                  toY: furnitureData,
                  width: 15,
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(4)),
            ]),
            BarChartGroupData(x: 2, barRods: [
              BarChartRodData(
                  toY: accessoriesData,
                  width: 15,
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(4)),
            ]),
            BarChartGroupData(x: 3, barRods: [
              BarChartRodData(
                  toY: electronicsData,
                  width: 15,
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(4)),
            ]),
          ])),
    );
  }
}

Widget getBottomTitleData(double value, TitleMeta meta) {
  Widget text;
  switch (value.toInt()) {
    case 1:
      text = const Text("Furniture");
      break;
    case 2:
      text = const Text("Accessories");
      break;
    case 3:
      text = const Text("Electronics");
      break;

    default:
      text = const Text("");
      break;
  }
  return SideTitleWidget(child: text, axisSide: meta.axisSide);
}
