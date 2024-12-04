import 'package:flutter/material.dart';
import 'package:cube_timer/src/pages/Widgets/stopwatch_timer.dart';
import 'package:cube_timer/src/controllers/TimerController.dart';
import 'package:get/get.dart';

class Timer extends StatelessWidget {
  Timer({super.key});

  final StopwatchController controller = Get.put(StopwatchController());

  
  @override
  Widget build(BuildContext context) {
    
    return Card(
      child:InkWell(
        onTap: () {controller.start();},
        child:Column(
          children: [
            SizedBox(height: 350,),
            TimerText(),
          ],
        )
      )
    );
  }
}

