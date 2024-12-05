import 'package:flutter/material.dart';
import 'package:cube_timer/src/pages/Widgets/stopwatch_timer.dart';
import 'package:cube_timer/src/controllers/TimerController.dart';
import 'package:get/get.dart';
import 'package:cube_timer/src/controllers/ScrambleGenerator.dart';

class Timer extends StatelessWidget {
  Timer({super.key});

  final StopwatchController controller = Get.put(StopwatchController());
  final RxString scrambleText = generateScramble().obs; 
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          if (controller.isRunning()) {
            controller.stop();
            scrambleText.value = generateScramble();
          } else {
            controller.reset();
            controller.start();
          }
        },
        child: Column(
          children: [
            const SizedBox(height: 70),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Card(
                child: InkWell(
                  onTap: () => scrambleText.value = generateScramble(), 
                  child: Obx(() => Text( 
                    scrambleText.value,
                    style: const TextStyle(fontSize: 25),
                    textAlign: TextAlign.center,
                  )),
                ),
              ),
            ),
            const SizedBox(height: 250),
            TimerText(),
          ],
        ),
      ),
    );
  }
}


