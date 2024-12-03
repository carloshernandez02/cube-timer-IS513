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
        return ListTile(
          leading: Text(formatDate(solve?.date)),
          title: Text(formatTime(solve?.time ?? Duration.zero))
        );
      },
    );
  }
}

String formatTime(Duration time) {
  if (time < Duration(minutes: 1)) {

    return '${time.inSeconds}.${time.inMilliseconds % 1000}';
  } else {

    final minutes = time.inMinutes;
    final seconds = time.inSeconds % 60; 
    final milliseconds = time.inMilliseconds % 1000;
    return '$minutes:${seconds.toString().padLeft(2, '0')}.$milliseconds';
  }
}

String formatDate(DateTime? date) {
  if (date == null) return '';
  final hour = date.hour;
  final minute = date.minute.toString().padLeft(2, '0');
  final day = date.day;
  final month = date.month;
  final year = date.year;
  return '$day/$month/$year at $hour:$minute';
}