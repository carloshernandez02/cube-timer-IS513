import 'package:cube_timer/src/controllers/PageIndex.dart';
import 'package:cube_timer/src/fragments/summary_fragment.dart';
import 'package:cube_timer/src/fragments/timer_fragment.dart';
import 'package:cube_timer/src/fragments/times_fragment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageViewer extends StatelessWidget {
  PageViewer({
    super.key,
  });

  final PageIndex controladorIndice = Get.find<PageIndex>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => PageView(
          controller: controladorIndice.pageController,
          physics: controladorIndice.isTimerRunning
              ? const NeverScrollableScrollPhysics()
              : const AlwaysScrollableScrollPhysics(),
          children: [
            Timer(),
            Times(),
            Summary(),
          ],
          onPageChanged: (page) {
            // Ocultar cualquier BottomSheet abierto
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
            controladorIndice.currentIndex = page;
            print(controladorIndice.currentIndex);
          },
        ));
  }
}
