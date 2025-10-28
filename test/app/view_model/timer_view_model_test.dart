import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fokus/app/view_model/timer_view_model.dart';

void main() {
  group('Timer ViewModel', () {
    late TimerViewModel timerViewModel;
    late ValueNotifier<bool> isPaused;

    // inicialize variables before each test
    setUp(() {
      timerViewModel = TimerViewModel();
      isPaused = ValueNotifier<bool>(false);
    });

    test('should start time with duration zero', () {
      expect(timerViewModel.isPlaying, false);
      expect(timerViewModel.duration, Duration.zero);
    });

    group('startTimer', () {
      test('should start the timer and set duration to zero', () {
        timerViewModel.duration = Duration(minutes: 5);
        timerViewModel.startTimer(5, isPaused);
        expect(timerViewModel.isPlaying, true);
        expect(timerViewModel.duration, Duration.zero);
      });

      test('should increment duration every second when not paused', () async {
        timerViewModel.startTimer(5, isPaused);
        await Future.delayed(Duration(seconds: 1));
        expect(timerViewModel.duration.inSeconds, 1);
      });

      test('should not increment duration when paused', () async {
        isPaused.value = true;
        timerViewModel.startTimer(5, isPaused);
        await Future.delayed(Duration(seconds: 1));
        expect(timerViewModel.duration.inSeconds, 0);

        isPaused.value = false;
        await Future.delayed(Duration(seconds: 1));
        expect(timerViewModel.duration.inSeconds, 1);
      });
    });

    group('stopTimer', () {
      test('should stop the timer and set isPlaying to false', () {
        timerViewModel.startTimer(5, isPaused);
        expect(timerViewModel.isPlaying, true);

        timerViewModel.stopTimer();
        expect(timerViewModel.isPlaying, false);
      });
    });
  });
}
