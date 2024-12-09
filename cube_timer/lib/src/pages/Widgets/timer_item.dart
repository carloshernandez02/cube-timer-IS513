import 'package:cube_timer/data/classes/solve.dart';
import 'package:flutter/material.dart';

class TimerItem extends StatelessWidget {
  const TimerItem({
    super.key,
    required this.solve,
    required this.onDelete,
  });
  final VoidCallback onDelete;
  final Solve? solve;
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
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          trailing: IconButton(onPressed: onDelete, icon: Icon(Icons.delete)),
          subtitle: solve?.comment != null ? Text('${solve!.comment}') : null,
          onTap: () {
            showBottomSheet(
              context: context,
              builder: (context) {
                TextEditingController commentText = TextEditingController();
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Column(
                      children: [
                        (TextField(
                          controller: commentText,
                          decoration: InputDecoration(
                            labelText: 'Comentario',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) => solve?.comment,
                        )),
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
                              )),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 5, right: 5),
                                child: SizedBox(
                                    child: Card(
                                        child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(solve!.scramble),
                                    )),
                                    width: 275),
                              ),
                            ],
                          ),
                        ),
                        Text(solve!.dnf.toString()),
                      ],
                      
                    ),
                  ),
                ); //TODO: Enviar edicion de comentario y menu de etiquetas
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
  if (time < Duration(minutes: 1)) {
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
