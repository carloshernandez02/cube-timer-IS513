import 'package:cube_timer/src/pages/Widgets/timer_item.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:cube_timer/data/classes/box_names.dart';
import 'package:cube_timer/data/classes/solve.dart';

class Times extends StatelessWidget {
  const Times({super.key});
  
  @override
  Widget build(BuildContext context) {
    final solves = Hive.box<Solve>(solveBox);
    return solves.isEmpty ? const Center(child: Text('No hay resoluciones'),) 
    : ListView.builder(
      itemCount: solves.length,
      itemBuilder: (BuildContext context, int index) {
        final solve = solves.getAt(solves.length - index - 1);
        return TimerItem(solve: solve);
      },
    );
  }
}

