import 'package:get/get.dart';
import 'package:hive_ce/hive.dart';
import 'package:cube_timer/data/classes/solve.dart';
import 'package:cube_timer/data/classes/box_names.dart';

class PBController extends GetxController {
  final personalBest = Rxn<Duration>();
  final solves = Hive.box<Solve>(solveBox);

  
  @override
  void onInit() {
    super.onInit();
    _initializePB();
  }

  
  void _initializePB() {
    if (solves.isEmpty) {
      personalBest.value = null; 
    } else {
      Duration? bestTime;

      
      for (var solve in solves.values) {
        if (solve.dnf != true) { 
          if (bestTime == null || solve.time < bestTime) {
            bestTime = solve.time; 
          }
        }
      }

      
      personalBest.value = bestTime;
    }
  }

  void updatePB(Duration newTime) {
    if (personalBest.value == null || newTime < personalBest.value!) {
      personalBest.value = newTime;
    }
  }
}

