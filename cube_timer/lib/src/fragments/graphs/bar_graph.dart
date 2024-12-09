import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:cube_timer/data/stat_funcs.dart';

class BarGraph extends StatelessWidget {
  final List<int> times;

  const BarGraph({required this.times});

  @override
  Widget build(BuildContext context) {
    if (times.length <= 1 || times.isEmpty) {
      return Card(child: Text('No hay suficientes tiempos'));
    } else {
      final stat = StatFuncs();
      final Map<String, int> distribution = {};

     
      const int desiredBars = 5; 
      final timesInSeconds = times.map((time) => time / 1000).toList();
      final minTime = timesInSeconds.reduce((a, b) => a < b ? a : b);
      final maxTime = timesInSeconds.reduce((a, b) => a > b ? a : b);
      final totalRange = maxTime - minTime;
      final rangeSize = totalRange / desiredBars;

      for (var time in timesInSeconds) {
        final lowerBound =
            ((time - minTime) / rangeSize).floor() * rangeSize + minTime;
        final upperBound = lowerBound + rangeSize;
        final range =
            '${lowerBound.toStringAsFixed(2)}-${upperBound.toStringAsFixed(2)}s';
        distribution[range] = (distribution[range] ?? 0) + 1;
      }

      final sortedRanges = distribution.keys.toList()
        ..sort((a, b) => double.parse(a.split('-').first)
            .compareTo(double.parse(b.split('-').first)));

      return AspectRatio(
        aspectRatio: 1.5,
        child: Card(
          child: BarChart(
            BarChartData(
              gridData: FlGridData(show: false),
              titlesData: FlTitlesData(
                topTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                leftTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      final index = value.toInt();
                      if (index < 0 || index >= sortedRanges.length) {
                        return const SizedBox.shrink();
                      }
                      return Text(sortedRanges[index], style: const TextStyle(fontSize: 8),);
                    },
                    reservedSize: 30,
                  ),
                ),
              ),
              borderData: FlBorderData(
                show: true,
                border: const Border(
                  right: BorderSide(color: Colors.black),
                  bottom: BorderSide(color: Colors.black),
                ),
              ),
              barGroups: sortedRanges
                  .asMap()
                  .entries
                  .map(
                    (entry) => BarChartGroupData(
                      x: entry.key,
                      barRods: [
                        BarChartRodData(
                          toY: distribution[entry.value]!.toDouble(),
                          width: 20,
                          color: Colors.green,
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      );
    }
  }
}
