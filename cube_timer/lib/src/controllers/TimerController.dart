import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StopwatchController extends GetxController {
  final Stopwatch _stopwatch = Stopwatch();
  final RxString elapsedTime = '00:00.000'.obs;
  Timer? _timer;
  final Rx<Color> timerColor = Colors.black.obs;
  
  void start() {
    if (!_stopwatch.isRunning) {
      _stopwatch.start();
      _timer = Timer.periodic(Duration(milliseconds: 16), (timer) {
        final duration = _stopwatch.elapsed;
        elapsedTime.value = _formatDuration(duration);
      });
    }
  }


  void stop() {
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
      _timer?.cancel();
      elapsedTime.value = _formatDuration(_stopwatch.elapsed);
    }
  }

  void reset() {
    stop();
    _stopwatch.reset();
    elapsedTime.value = '00:00.000';
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String threeDigits(int n) => n.toString().padLeft(3,'0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    final milliseconds = threeDigits(duration.inMilliseconds.remainder(1000));
    return '$minutes:$seconds.$milliseconds';
  }


  get duration => _stopwatch.elapsed;

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  bool isRunning() {
    return _stopwatch.isRunning;
  }

}
