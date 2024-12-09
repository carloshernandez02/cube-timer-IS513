import 'package:cube_timer/data/classes/solve.dart';
import 'package:flutter/material.dart';

class TimerItem extends StatelessWidget {
  TimerItem({
    super.key,
    required this.solve,
    required this.onDelete,
    required this.commentChange,
    required this.commentText,
  });

  final VoidCallback onDelete;
  final VoidCallback commentChange;
  final Solve? solve;
  final TextEditingController commentText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: Card(
        child: ListTile(
          title: Row(
            children: [
              Text(
                formatTime(solve?.time ?? Duration.zero),
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
          trailing: IconButton(onPressed: onDelete, icon: const Icon(Icons.delete)),
          subtitle: solve?.comment != null ? Text('${solve!.comment}') : null,
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
                            commentText.text = value; // Actualiza el texto local
                          },
                        ),
                        ElevatedButton(
                          onPressed: commentChange,
                          child: const Text('Guardar comentario'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Row(
                            children: [
                              Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    formatDate(solve?.date),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5, right: 5),
                                child: SizedBox(
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(solve!.scramble),
                                    ),
                                  ),
                                  width: 275,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(solve!.dnf.toString()),
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
