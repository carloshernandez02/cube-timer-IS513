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
    return ListTile(
      leading: Text(formatDate(solve?.date)),
      title: Text(formatTime(solve?.time ?? Duration.zero)),
      subtitle: Text(solve!.scramble),
      trailing: IconButton(onPressed: onDelete , icon: Icon(Icons.delete)),
      onTap: (){
        showBottomSheet(context: context, builder: (context){
          TextEditingController commentText = TextEditingController();         
          return Column(
            children: [
              TextField(
                controller: commentText,
                decoration: InputDecoration(
                  labelText: 'Comentario',
                ),
              )
            ],
          ); //TODO: Enviar edicion de comentario y menu de etiquetas
        },
        enableDrag: true,
        showDragHandle: true,
        );
      },
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