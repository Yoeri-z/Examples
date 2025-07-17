import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartWidget extends StatelessWidget {
  const BarChartWidget({super.key});

  BarChartData get data => BarChartData(
    borderData: FlBorderData(border: Border.all(color: Colors.white)),
    maxY: 4,
    gridData: FlGridData(horizontalInterval: 1),
    barGroups: [
      BarChartGroupData(
        x: 1,
        barRods: [
          BarChartRodData(toY: 2, width: 20),
          BarChartRodData(toY: 1, color: Colors.grey, width: 10),
        ],
      ),
      BarChartGroupData(
        x: 2,
        barRods: [
          BarChartRodData(
            toY: 3.5,
            width: 20,
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.orange],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          BarChartRodData(toY: 2, color: Colors.grey, width: 10),
        ],
      ),
      BarChartGroupData(
        x: 3,
        barRods: [
          BarChartRodData(
            toY: 3,
            width: 20,
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.orange],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          BarChartRodData(toY: 0.5, color: Colors.grey, width: 10),
        ],
      ),
    ],
    titlesData: FlTitlesData(
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          reservedSize: 34,
          showTitles: true,
          minIncluded: false,
          maxIncluded: false,
        ),
      ),
      rightTitles: AxisTitles(),
      topTitles: AxisTitles(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return BarChart(data);
  }
}
