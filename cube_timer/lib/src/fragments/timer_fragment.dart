import 'package:cube_timer/data/classes/solve.dart';
import 'package:cube_timer/src/controllers/PageIndex.dart';
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
  final PageIndex pageController = Get.find<PageIndex>();
  final RxString scrambleText = generateScramble().obs;
  final delay = Stopwatch();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        delay.stop();
        delay.reset();
      },
      onLongPress: () {
        if (controller.elapsedTime.toString() != '0:00.000') controller.reset();
        delay.start();
        Future.doWhile(() async {
          if (delay.isRunning) {
            controller.timerColor.value = delay.elapsed >= const Duration(milliseconds: 600)
                ? Colors.green
                : Colors.red;
          }
          await Future.delayed(const Duration(milliseconds: 100));
          return delay.isRunning;
        });
      },
      onLongPressEnd: (details) {
        if (delay.elapsed > const Duration(milliseconds: 600)) {
          controller.timerColor.value = Colors.black;
          controller.start();
          pageController.isTimerRunning = true;
          delay.stop();
          delay.reset();
        }else{
          delay.stop();
          delay.reset();
          controller.timerColor.value = Colors.black;
        }
      },
      //TODO: Agregar botones para taggear el solve con penalizaciones, como marcar +2 o DNF
      child: InkWell(
        onTap: () {
          if (controller.isRunning()) {
            controller.stop();
            pageController.isTimerRunning = false;
            final finaltime = controller.duration;
            print('Saving time: ${controller.duration.inMilliseconds}');
            final solve = Solve(
                scramble: scrambleText.value,
                date: DateTime.now(),
                time: finaltime);
            Hive.box<Solve>(solveBox).add(solve);
            scrambleText.value = generateScramble();
          } else {
            controller.reset();
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
                  child: Obx(() => controller.isRunning()
                  ? const SizedBox.shrink()
                  :Text(
                        scrambleText.value,
                        style: const TextStyle(fontSize: 25),
                        textAlign: TextAlign.center,
                      )),
                ),
              ),
            ),
            const SizedBox(height: 250),
            TimerText(),
            //TODO: Agregar estadisticas Ao5 - Ao100 a esta pantalla para facil visualizacion
          ],
        ),
      ),
    );
  }
}
