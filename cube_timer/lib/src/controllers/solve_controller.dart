import 'package:get/get.dart';
import 'package:cube_timer/data/classes/solve.dart';

class SolveController extends GetxController {
  late Solve solve;

  void initialize(Solve solveInstance) {
    solve = solveInstance;
  }

  void toggleDnf(bool value) {
    solve.dnf = value;
    if (value) {
      solve.mas2 = false; // Si DNF es true, mas2 debe ser false
    }
    solve.save(); // Guarda los cambios en Hive
    update(); // Notifica a la UI para que se actualice
  }

  void toggleMas2(bool value) {
    solve.mas2 = value;
    if (value) {
      solve.dnf = false; // Si mas2 es true, DNF debe ser false
    }
    solve.save(); // Guarda los cambios en Hive
    update(); // Notifica a la UI para que se actualice
  }
}



