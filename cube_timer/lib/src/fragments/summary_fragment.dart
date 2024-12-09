import 'package:cube_timer/src/controllers/PBController.dart';
import 'package:cube_timer/src/fragments/graphs/bar_graph.dart';
import 'package:cube_timer/src/fragments/graphs/line_graph.dart';
import 'package:cube_timer/src/pages/Widgets/stat_item.dart';
import 'package:flutter/material.dart';
import 'package:cube_timer/data/classes/solve.dart';
import 'package:get/get.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:cube_timer/data/classes/box_names.dart';
import 'package:cube_timer/data/stat_funcs.dart';

class Summary extends StatelessWidget {
  const Summary({super.key});

  @override
  Widget build(BuildContext context) {
    final pbController = Get.find<PBController>(); // Obtén el controlador
    final solvesBox = Hive.box<Solve>(solveBox);
    final solves = solvesBox.values.toList();
    final StatFuncs stats = StatFuncs();

    if (solves.isEmpty) {
      return const Center(
        child: Text('No data available'),
      );
    }

    // Extract times and sort them
    final times = solves.map((solve) => solve.time.inMilliseconds).toList();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0, left: 12.0, right: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              'Line Graph: Solve Times',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            LineGraph(times: times),
            const SizedBox(height: 30),
            const Text(
              'Bar Graph: Solve Time Distribution',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            BarGraph(times: times),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Obx(
                  ()=> StatItem(
                    title: 'Personal Best',
                    stat: pbController.personalBest.value != null
                        ? _formatDuration(pbController.personalBest.value)
                        : 'N/A',
                  ),
                ),
                StatItem(
                  title: 'Total Solves',
                  stat: solvesBox.length.toString(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                StatItem(
                  title: 'Promedio Bruto',
                  stat: stats.mediaBruta(),
                ),
                StatItem(
                  title: 'Desviacion estandar',
                  stat: stats.desviacionEstandar(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

String _formatDuration(Duration? duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String threeDigits(int n) => n.toString().padLeft(3, '0');
    String average;

    if (duration! > const Duration(minutes: 1)) {
      final minutes = twoDigits(duration!.inMinutes.remainder(60));
      final seconds = twoDigits(duration.inSeconds.remainder(60));
      final milliseconds = threeDigits(duration.inMilliseconds.remainder(1000));
      average = '$minutes:$seconds.$milliseconds';
    } else {
      final seconds = twoDigits(duration!.inSeconds.remainder(60));
      final milliseconds = threeDigits(duration.inMilliseconds.remainder(1000));
      average = '$seconds.$milliseconds';
    }
    return average;
  }