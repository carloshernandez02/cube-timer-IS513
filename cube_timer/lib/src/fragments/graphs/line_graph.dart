import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineGraph extends StatelessWidget {
  final List<int> times;

  const LineGraph({required this.times});

  //TODO: Meterle ***DISEÑO*** 
  @override
  Widget build(BuildContext context) {
    return Card(
      child: AspectRatio(
        aspectRatio: 1.5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: LineChart(
            LineChartData(
              gridData: FlGridData(drawHorizontalLine: true, drawVerticalLine: false, ),
              titlesData: const FlTitlesData(
                topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                leftTitles: AxisTitles(axisNameWidget: Text('Duracion'), axisNameSize: 24),
                bottomTitles: AxisTitles(axisNameWidget: Text('Tiempos'))
              ),
              borderData: FlBorderData(
                show: true,
                border: const Border(
                  left: BorderSide(color: Colors.black),
                  bottom: BorderSide(color: Colors.black),
                ),
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: times
                      .asMap()
                      .entries
                      .map((entry) => FlSpot(entry.key.toDouble(),
                          entry.value.toDouble() / 1000)) 
                      .toList(),
                  isCurved: true,
                  preventCurveOverShooting: true,
                  color: Colors.blue,
                  barWidth: 3,
                  isStrokeCapRound: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}