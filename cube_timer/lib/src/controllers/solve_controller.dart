import 'package:get/get.dart';
import 'package:cube_timer/data/classes/solve.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class SolveController extends GetxController {
  late Solve solve;
  dynamic? solveKey;
  Box<Solve>? box;

  void initialize(Solve initialSolve, dynamic? key, Box<Solve>? hiveBox) {
    solve = initialSolve;
    solveKey = key;
    box = hiveBox;
  }

  void toggleDNF(bool value) {
    solve.dnf = value;
    if (value) solve.mas2 = false; // DNF disables +2
    if (box != null && solveKey != null) {
      box!.put(solveKey, solve); // Save changes to Hive
    }
    update(); // Rebuild UI
  }

  void toggleMas2(bool value) {
    solve.mas2 = value;
    if (value) solve.dnf = false; // +2 disables DNF
    if (box != null && solveKey != null) {
      box!.put(solveKey, solve); // Save changes to Hive
    }
    update(); // Rebuild UI
  }
}
