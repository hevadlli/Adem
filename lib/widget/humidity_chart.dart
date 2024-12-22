import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HumidityChart extends StatelessWidget {
  final List<FlSpot> dataPoints;

  HumidityChart({required this.dataPoints});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: dataPoints,
            isCurved: true,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(show: false),
            colors: [Colors.blue],
            barWidth: 2,
          ),
        ],
        minY: 0,
        maxY: 100,
      ),
    );
  }
}
