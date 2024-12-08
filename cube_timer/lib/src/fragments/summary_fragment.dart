import 'package:cube_timer/src/fragments/graphs/bar_graph.dart';
import 'package:cube_timer/src/fragments/graphs/line_graph.dart';
import 'package:flutter/material.dart';
import 'package:cube_timer/data/classes/solve.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:cube_timer/data/classes/box_names.dart';
import 'package:cube_timer/data/stat_funcs.dart';

class Summary extends StatelessWidget {
  const Summary({super.key});
  //TODO: Meterle ***DISEÑO*** 
  @override
  Widget build(BuildContext context) {
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
              children: [
                Card(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      Text('Promedio Bruto'),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "${stats.mediaBruta()}",
                        style: TextStyle(fontSize: 24),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Card(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      Text('Desviacion estandar'),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "${stats.desviacionEstandar()}",
                        style: TextStyle(fontSize: 24),
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Card(
              child: Column(
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  Text('Resoluciones totales'),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "${solvesBox.length}",
                    style: TextStyle(fontSize: 24),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
