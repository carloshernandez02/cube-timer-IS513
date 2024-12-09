import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cube_timer/src/controllers/Solve_Controller.dart';
import 'package:cube_timer/data/classes/solve.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class TimerItem extends StatelessWidget {
  TimerItem({
    super.key,
    required this.solve,
    required this.onDelete,
    required this.commentChange,
    required this.commentText,
    required this.solveKey,
    required this.box,
  });

  final VoidCallback onDelete;
  final VoidCallback commentChange;
  final Solve solve;
  final TextEditingController commentText;
  final dynamic solveKey;
  final Box<Solve> box;

  @override
  Widget build(BuildContext context) {
    // Initialize SolveController
    final SolveController controller = Get.put(SolveController());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.solveKey != solveKey) {
        // Only initialize if the solveKey is different
        controller.initialize(solve, solveKey, box);
      }
    });

    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: Card(
        child: ListTile(
          title: Row(
            children: [
              Text(
                formatTime(solve.time),
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
          trailing: IconButton(
            onPressed: onDelete,
            icon: const Icon(Icons.delete),
          ),
          subtitle:
              solve.comment != null ? Text(solve.comment!) : null,
          onTap: () {
            showBottomSheet(
              context: context,
              builder: (context) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Column(
                      children: [
                        TextField(
                          controller: commentText,
                          decoration: const InputDecoration(
                            labelText: 'Comentario',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            commentText.text = value;
                          },
                        ),
                        ElevatedButton(
                          onPressed: commentChange,
                          child: const Text('Guardar comentario'),
                        ),
                        GetBuilder<SolveController>(
                          builder: (_) {
                            return SwitchListTile(
                              title: const Text("DNF"),
                              value: controller.solve.dnf,
                              onChanged: (bool value) {
                                controller.toggleDNF(value);
                              },
                            );
                          },
                        ),
                        GetBuilder<SolveController>(
                          builder: (_) {
                            return SwitchListTile(
                              title: const Text("+2"),
                              value: controller.solve.mas2,
                              onChanged: (bool value) {
                                controller.toggleMas2(value);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
              enableDrag: true,
              showDragHandle: true,
            );
          },
        ),
      ),
    );
  }
}

String formatTime(Duration time) {
  final milliseconds = (time.inMilliseconds % 1000).toString().padLeft(3, '0');
  if (time < const Duration(minutes: 1)) {
    return '${time.inSeconds}.$milliseconds';
  } else {
    final minutes = time.inMinutes;
    final seconds = time.inSeconds % 60;
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
  return '''$day/$month/$year 
    $hour:$minute''';
}
