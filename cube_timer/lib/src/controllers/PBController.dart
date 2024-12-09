import 'package:get/get.dart';
import 'package:hive_ce/hive.dart';
import 'package:cube_timer/data/classes/solve.dart';
import 'package:cube_timer/data/classes/box_names.dart';

class PBController extends GetxController {
  final personalBest = Rxn<Duration>();
  final solves = Hive.box<Solve>(solveBox); // Caja de soluciones

  // Inicialización del PB cuando se crea el controlador
  @override
  void onInit() {
    super.onInit();
    _initializePB();
  }

  // Método para inicializar el personalBest con el valor del Box
  void _initializePB() {
    if (solves.isEmpty) {
      personalBest.value = null; // Si no hay tiempos en la caja, PB es null
    } else {
      Duration? bestTime;

      // Recorremos todos los solves y buscamos el mejor (menor) tiempo
      for (var solve in solves.values) {
        if (solve.dnf != true) { // Ignoramos los tiempos DNF
          if (bestTime == null || solve.time < bestTime) {
            bestTime = solve.time; // Actualizamos el PB si encontramos un mejor tiempo
          }
        }
      }

      // Asignamos el mejor tiempo encontrado
      personalBest.value = bestTime;
    }
  }

  // Método para actualizar el Personal Best con un nuevo tiempo
  void updatePB(Duration newTime) {
    if (personalBest.value == null || newTime < personalBest.value!) {
      personalBest.value = newTime;
    }
  }
}

