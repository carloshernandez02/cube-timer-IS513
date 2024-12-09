import 'dart:math';
import 'package:cube_timer/data/classes/solve.dart';
import 'package:hive_ce/hive.dart';
import 'package:cube_timer/data/classes/box_names.dart';

class StatFuncs {
  StatFuncs();
  List<int> sortedTimes = Hive.box<Solve>(solveBox)
      .values
      .map((solve) => solve.time.inMilliseconds)
      .toList()
    ..sort();

  String? aox(int timeCount) {
    if (sortedTimes.length < timeCount) {
      return 'N/A';
    } else {
      final lastXTimes = sortedTimes.sublist(sortedTimes.length - timeCount);
      String? aoX;

      final averageMs =
          (lastXTimes.reduce((a, b) => a + b) / (lastXTimes.length.toDouble()-2));

      final duration = Duration(milliseconds: averageMs.round());
      String twoDigits(int n) => n.toString().padLeft(2, '0');
      String threeDigits(int n) => n.toString().padLeft(3, '0');

      if (duration > const Duration(minutes: 1)) {
        final minutes = twoDigits(duration.inMinutes.remainder(60));
        final seconds = twoDigits(duration.inSeconds.remainder(60));
        final milliseconds =
            threeDigits(duration.inMilliseconds.remainder(1000));
        aoX = '$minutes:$seconds.$milliseconds';
      } else {
        final seconds = twoDigits(duration.inSeconds.remainder(60));
        final milliseconds =
            threeDigits(duration.inMilliseconds.remainder(1000));
        aoX = '$seconds.$milliseconds';
      }
      return aoX;
    }
  }

  String mediaBruta() {
    final averageMs =
        (sortedTimes.reduce((a, b) => a + b) / sortedTimes.length.toDouble());
    String? average;
    final duration = Duration(milliseconds: averageMs.round());
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String threeDigits(int n) => n.toString().padLeft(3, '0');

    if (duration > const Duration(minutes: 1)) {
      final minutes = twoDigits(duration.inMinutes.remainder(60));
      final seconds = twoDigits(duration.inSeconds.remainder(60));
      final milliseconds = threeDigits(duration.inMilliseconds.remainder(1000));
      average = '$minutes:$seconds.$milliseconds';
    } else {
      final seconds = twoDigits(duration.inSeconds.remainder(60));
      final milliseconds = threeDigits(duration.inMilliseconds.remainder(1000));
      average = '$seconds.$milliseconds';
    }
    return average;
  }

  desviacionEstandar({bool rawValue = false}) {
    if (sortedTimes.length <= 1) return 'N/A';
    double media =
        (sortedTimes.reduce((a, b) => a + b) / sortedTimes.length.toDouble());
    double sum = 0;
    String desviacion;
    for (int i = 0; i < sortedTimes.length; i++) {
      sum += pow((sortedTimes[i] - media), 2);
    }
    sum = sqrt(sum / sortedTimes.length);
    if (rawValue) {
      sum = sum / 1000;
      return sum;
    }

    final duration = Duration(milliseconds: sum.round());
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String threeDigits(int n) => n.toString().padLeft(3, '0');

    if (duration > const Duration(minutes: 1)) {
      final minutes = twoDigits(duration.inMinutes.remainder(60));
      final seconds = twoDigits(duration.inSeconds.remainder(60));
      final milliseconds = threeDigits(duration.inMilliseconds.remainder(1000));
      desviacion = '+- $minutes:$seconds.$milliseconds';
    } else {
      final seconds = twoDigits(duration.inSeconds.remainder(60));
      final milliseconds = threeDigits(duration.inMilliseconds.remainder(1000));
      desviacion = '+- $seconds.$milliseconds';
    }
    return desviacion;
  }
}
