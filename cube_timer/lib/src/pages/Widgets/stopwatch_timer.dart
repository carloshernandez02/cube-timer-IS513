import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cube_timer/src/controllers/TimerController.dart';

class TimerText extends StatelessWidget {
  TimerText({super.key});
  final StopwatchController controller = Get.find<StopwatchController>();

  @override
  Widget build(BuildContext context) {
    return Obx(()=>
        Text(
        controller.elapsedTime.value,
        style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: controller.timerColor.value),
      ),
    );
  }
}

