import 'package:cube_timer/data/classes/solve.dart';
import 'package:flutter/material.dart';

class TimerItem extends StatelessWidget {
  const TimerItem({
    super.key,
    required this.solve,
  });

  final Solve? solve;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(formatDate(solve?.date)),
      title: Text(formatTime(solve?.time ?? Duration.zero)),
      subtitle: Text(solve!.scramble),
    
      onTap: (){
        showBottomSheet(context: context, builder: (context){
          print('Retrieved time: ${solve!.time.inMilliseconds}');
          print('Formatted time: ${formatTime(solve!.time)}');

          return Text("ejem testing"); //TODO: Enviar edicion de comentario y menu de etiquetas
        },
        elevation: 50,
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
  return '$day/$month/$year at $hour:$minute';
}