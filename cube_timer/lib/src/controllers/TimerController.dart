import 'dart:async';
import 'package:get/get.dart';

class StopwatchController extends GetxController {
  final Stopwatch _stopwatch = Stopwatch();
  final RxString elapsedTime = '00:00:00'.obs;
  Timer? _timer;

  void start() {
    if (!_stopwatch.isRunning) {
      _stopwatch.start();
      _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
        final duration = _stopwatch.elapsed;
        elapsedTime.value = _formatDuration(duration);
      });
    }
  }

  void stop() {
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
      _timer?.cancel();
    }
  }

  void reset() {
    stop();
    _stopwatch.reset();
    elapsedTime.value = '00:00:00';
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    final milliseconds = twoDigits(duration.inMilliseconds.remainder(99));
    return '$minutes:$seconds:$milliseconds';
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
