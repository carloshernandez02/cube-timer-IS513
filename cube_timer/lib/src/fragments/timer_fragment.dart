import 'package:cube_timer/data/classes/solve.dart';
import 'package:cube_timer/src/controllers/PageIndex.dart';
import 'package:flutter/material.dart';
import 'package:cube_timer/src/pages/Widgets/stopwatch_timer.dart';
import 'package:cube_timer/src/controllers/TimerController.dart';
import 'package:get/get.dart';
import 'package:cube_timer/src/controllers/ScrambleGenerator.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:cube_timer/data/classes/box_names.dart';
import 'package:cube_timer/src/controllers/PBController.dart';
import 'package:cube_timer/src/pages/Widgets/stat_item.dart';
import 'package:cube_timer/data/stat_funcs.dart';

class Timer extends StatelessWidget {
  Timer({super.key});

  final PBController pbController = Get.put(PBController());
  final StopwatchController controller = Get.put(StopwatchController());
  final PageIndex pageController = Get.find<PageIndex>();
  final RxString scrambleText = generateScramble().obs;
  final delay = Stopwatch();
  late final Duration? currentPB;
  late final bool isPB;
  final stats = StatFuncs();

  Duration? getPersonalBest(Box<Solve> box) {
    if (box.isEmpty) return null;
    return box.values
        .where((solve) => solve.dnf != true)
        .map((solve) => solve.time)
        .reduce((value, element) => value < element ? value : element);
  }

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
            controller.timerColor.value =
                delay.elapsed >= const Duration(milliseconds: 600)
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
        } else {
          delay.stop();
          delay.reset();
          controller.timerColor.value = Colors.black;
        }
      },
      child: InkWell(
        onTap: () {
          if (controller.isRunning()) {
            controller.stop();
            pageController.isTimerRunning = false;
            final finaltime = controller.duration;

            final box = Hive.box<Solve>(solveBox);

            currentPB = getPersonalBest(box);
            isPB = currentPB == null || finaltime < currentPB;

            final solve = Solve(
              scramble: scrambleText.value,
              date: DateTime.now(),
              time: finaltime,
            );

            box.add(solve);

            pbController.updatePB(finaltime);

            if (isPB) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('¡Nuevo Personal Best! 🎉'),
                ),
              );
            }

            scrambleText.value = generateScramble();
          } else {
            controller.reset();
          }
        },
        child: Column(
          children: [
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Card(
                child: InkWell(
                  onTap: () => scrambleText.value = generateScramble(),
                  child: Obx(() => controller.isRunning()
                      ? const SizedBox.shrink()
                      : Text(
                          scrambleText.value,
                          style: const TextStyle(fontSize: 25),
                          textAlign: TextAlign.center,
                        )),
                ),
              ),
            ),
            const SizedBox(height: 250),
            TimerText(),
            const SizedBox(height: 50),
            ValueListenableBuilder(
              valueListenable: Hive.box<Solve>(solveBox).listenable(),
              builder: (context, box, _) {
                final hasSolves = box.isNotEmpty;

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (hasSolves && !controller.isRunning())
                      ElevatedButton(
                        onPressed: () {
                          final lastKey = box.keys.last;
                          final Solve? lastSolve = box.get(lastKey);
                          if (lastSolve != null) {
                            lastSolve.dnf = true;
                            lastSolve.save();
                          }
                        },
                        child: const Text('DNF'),
                      ),
                    if (hasSolves && !controller.isRunning())
                      ElevatedButton(
                        onPressed: () {
                          final lastKey = box.keys.last;
                          final Solve? lastSolve = box.get(lastKey);
                          if (lastSolve != null) {
                            lastSolve.mas2 = true;
                            lastSolve.save();
                          }
                        },
                        child: const Text('+2'),
                      ),
                  ],
                );
              },
            ),
            controller.isRunning()
                ? const SizedBox.shrink()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          StatItem(title: 'Ao5', stat: stats.aox(5)),
                          StatItem(title: 'Ao12', stat: stats.aox(12)),
                        ],
                      )
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
