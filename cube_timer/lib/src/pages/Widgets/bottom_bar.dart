import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cube_timer/src/controllers/PageIndex.dart';

class BottomBar extends StatelessWidget {
  BottomBar({super.key});
  
  final PageIndex controladorIndice = Get.find<PageIndex>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => controladorIndice.isTimerRunning 
    ? const SizedBox.shrink() 
    : BottomNavigationBar(
        currentIndex: controladorIndice.currentIndex,
        onTap: (index) {

          controladorIndice.changePage(index);

        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.timer), label: 'Temporizador'),
          BottomNavigationBarItem(icon: Icon(Icons.view_timeline_sharp), label: 'Tiempos'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart_rounded), label: 'Estadisticas'),
        ]
      )
    );
  }
}