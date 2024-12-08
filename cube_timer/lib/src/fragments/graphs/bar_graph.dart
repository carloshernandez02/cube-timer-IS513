import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarGraph extends StatelessWidget {
  final List<int> times;

  const BarGraph({required this.times});

  @override
  Widget build(BuildContext context) {
    // Group times into ranges (e.g., 0-5s, 5-10s, etc.)
    final Map<String, int> distribution = {};
    for (var time in times) {
      final seconds = time ~/ 1000; // Convert milliseconds to seconds
      final range = '${(seconds ~/ 5) * 5}-${((seconds ~/ 5) + 1) * 5}s';
      distribution[range] = (distribution[range] ?? 0) + 1;
    }

    final sortedRanges = distribution.keys.toList()
      ..sort((a, b) => int.parse(a.split('-').first)
          .compareTo(int.parse(b.split('-').first)));

    //TODO: Meterle ***DISEÑO*** 
    return AspectRatio(
      aspectRatio: 1.5,
      child: Card(
        child: BarChart(
          BarChartData(
            gridData: FlGridData(show: false),
            titlesData: FlTitlesData(
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    final index = value.toInt();
                    if (index < 0 || index >= sortedRanges.length) {
                      return const SizedBox.shrink();
                    }
                    return Text(sortedRanges[index]);
                  },
                  reservedSize: 30,
                ),
              ),
            ),
            borderData: FlBorderData(
              show: true,
              border: const Border(
                left: BorderSide(color: Colors.black),
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