import 'package:cube_timer/data/classes/solve.dart';
import 'package:flutter/material.dart';
import 'package:cube_timer/src/pages/Widgets/stopwatch_timer.dart';
import 'package:cube_timer/src/controllers/TimerController.dart';
import 'package:get/get.dart';
import 'package:cube_timer/src/controllers/ScrambleGenerator.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:cube_timer/data/classes/box_names.dart';

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
            final finaltime = controller.duration;
            print('Saving time: ${controller.duration.inMilliseconds}');
            final solve = Solve(scramble: scrambleText.value, date: DateTime.now(), time: finaltime);
            Hive.box<Solve>(solveBox).add(solve);
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


