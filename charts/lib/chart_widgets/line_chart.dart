import 'dart:async';
import 'dart:math' as math;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartWidget extends StatefulWidget {
  const LineChartWidget({super.key});

  @override
  State<LineChartWidget> createState() => _LineChartWidgetState();
}

extension IsClose on num {
  bool isCloseTo(double other, [double epsilon = 1e-2]) {
    return (this - other).abs() < epsilon;
  }
}

class _LineChartWidgetState extends State<LineChartWidget> {
  var angle = 0.0;

  LineChartData get lineChartData => LineChartData(
    lineBarsData: List.generate(
      3,
      (i) => generateLineChartBarData(i, i * 2 * math.pi / 3),
    ),
    lineTouchData: LineTouchData(enabled: false),
    borderData: FlBorderData(
      border: Border(left: BorderSide(width: 1, color: Colors.white)),
    ),
    gridData: FlGridData(
      drawVerticalLine: false,
      checkToShowHorizontalLine: (val) {
        return val.isCloseTo(0);
      },
      getDrawingHorizontalLine:
          (_) => FlLine(color: Colors.white, strokeWidth: 2),
    ),
    maxY: 1.5,
    minY: -1.5,
    titlesData: FlTitlesData(
      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 44,
          getTitlesWidget: (value, meta) {
            String text = '';
            if (value.isCloseTo(0)) {
              text = '0';
            } else if (value.isCloseTo(1)) {
              text = '1';
            } else if (value.isCloseTo(-1)) {
              text = '-1';
            }
            return SideTitleWidget(
              meta: meta,
              child: Text(
                text,
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            );
          },
        ),
      ),
    ),
  );

  LineChartBarData generateLineChartBarData(int index, num phase) {
    return LineChartBarData(
      color: HSVColor.fromAHSV(1, index * 90.0, 1, 1).toColor(),
      barWidth: 4,
      spots: List.generate(100, (i) {
        final x = i / 15;
        final y = math.sin(x + angle + phase);
        return FlSpot(x, y);
      }),
      isCurved: true,
      dotData: FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
    );
  }

  late final Timer timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      angle += 0.1;
      setState(() {});
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LineChart(lineChartData);
  }
}
