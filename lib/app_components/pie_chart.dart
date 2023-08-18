import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartSample extends StatelessWidget {
  const PieChartSample(
      {super.key,
      required this.totalAccessories,
      required this.totalElectronics,
      required this.totalFurniture});
  final int totalFurniture;
  final int totalAccessories;
  final int totalElectronics;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.blueGrey[50],
        child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: AspectRatio(
                aspectRatio: 1.3,
                child: Row(
                  children: <Widget>[
                    const SizedBox(
                      height: 18,
                    ),
                    Expanded(
                        child: AspectRatio(
                      aspectRatio: 1,
                      child: PieChart(PieChartData(
                          centerSpaceRadius: double.infinity,
                          borderData: FlBorderData(show: false),
                          sections: [
                            PieChartSectionData(
                                value: totalAccessories.toDouble(),
                                color: Colors.purple,
                                radius: 100),
                            PieChartSectionData(
                                value: totalFurniture.toDouble(),
                                color: Colors.amber,
                                radius: 110),
                            PieChartSectionData(
                                value: totalElectronics.toDouble(),
                                color: Colors.green,
                                radius: 120)
                          ])),
                    )),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Indicator(
                          color: Colors.purple,
                          text: 'Accessories',
                          isSquare: true,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Indicator(
                          color: Colors.amber,
                          text: 'Furniture',
                          isSquare: true,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Indicator(
                          color: Colors.green,
                          text: 'Electronics',
                          isSquare: true,
                        ),
                        SizedBox(
                          height: 18,
                        ),
                      ],
                    ),
                  ],
                ))));
  }
}

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor,
  });
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        )
      ],
    );
  }
}
