import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class BarChartSample extends StatelessWidget {
  const BarChartSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 200,
      child: BarChart(BarChartData(
          borderData: FlBorderData(
              border: const Border(
            top: BorderSide.none,
            right: BorderSide.none,
            left: BorderSide(width: 1),
            bottom: BorderSide(width: 1),
          )),
          groupsSpace: 10,

          //add bars
          barGroups: [
            BarChartGroupData(x: 1, barRods: [
              BarChartRodData(toY: 10, width: 15, color: Colors.blue),
            ]),
            BarChartGroupData(x: 2, barRods: [
              BarChartRodData(toY: 12, width: 15, color: Colors.blue),
            ]),
            BarChartGroupData(x: 3, barRods: [
              BarChartRodData(toY: 14, width: 15, color: Colors.blue),
            ]),
            BarChartGroupData(x: 4, barRods: [
              BarChartRodData(toY: 16, width: 15, color: Colors.blue),
            ]),
            BarChartGroupData(x: 5, barRods: [
              BarChartRodData(toY: 18, width: 15, color: Colors.blue),
            ]),
            BarChartGroupData(x: 6, barRods: [
              BarChartRodData(toY: 20, width: 15, color: Colors.blue),
            ]),
            BarChartGroupData(x: 7, barRods: [
              BarChartRodData(toY: 22, width: 15, color: Colors.blue),
            ]),
            BarChartGroupData(x: 8, barRods: [
              BarChartRodData(toY: 24, width: 15, color: Colors.blue),
            ]),
          ])),
    );
  }
}
