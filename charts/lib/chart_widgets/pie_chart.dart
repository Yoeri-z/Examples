import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartWidget extends StatefulWidget {
  const PieChartWidget({super.key});

  @override
  State<PieChartWidget> createState() => _PieChartWidgetState();
}

class _PieChartWidgetState extends State<PieChartWidget> {
  int? touchedIndex;

  PieChartData get data => PieChartData(
    titleSunbeamLayout: true,
    centerSpaceRadius: 100,
    pieTouchData: PieTouchData(
      enabled: true,
      touchCallback: (event, response) {
        if (event is FlPointerHoverEvent) {
          touchedIndex = response?.touchedSection?.touchedSectionIndex;
          setState(() {});
        }
      },
    ),
    sections: [
      PieChartSectionData(
        value: 40,
        title: '40%',
        titleStyle: TextStyle(fontWeight: FontWeight.w700),
        color: Colors.orange,
        titlePositionPercentageOffset: 1.15,
        radius: touchedIndex == 0 ? 230 : 200,
        borderSide:
            touchedIndex == 0
                ? BorderSide(color: Colors.white, width: 4)
                : null,
      ),
      PieChartSectionData(
        value: 30,
        title: '30%',
        titleStyle: TextStyle(fontWeight: FontWeight.w700),
        titlePositionPercentageOffset: 1.15,
        radius: touchedIndex == 1 ? 230 : 200,
        borderSide:
            touchedIndex == 1
                ? BorderSide(color: Colors.white, width: 4)
                : null,
      ),
      PieChartSectionData(
        value: 20,
        title: '20%',
        titleStyle: TextStyle(fontWeight: FontWeight.w700),
        titlePositionPercentageOffset: 1.15,
        color: Colors.deepPurple,
        radius: touchedIndex == 2 ? 230 : 200,
        borderSide:
            touchedIndex == 2
                ? BorderSide(color: Colors.white, width: 4)
                : null,
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return PieChart(data, duration: Duration(milliseconds: 40));
  }
}
