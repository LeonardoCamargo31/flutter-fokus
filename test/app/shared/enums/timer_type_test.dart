import 'package:flutter_test/flutter_test.dart';
import 'package:fokus/app/shared/enums/timer_type.dart';

void main() {
  group('TimerType Enum', () {
    test('should contain three modes in TimerType enum', () {
      expect(TimerType.values.length, 3);

      expect(
        TimerType.values,
        containsAll([
          TimerType.focus,
          TimerType.shortBreak,
          TimerType.longBreak,
        ]),
      );
    });

    test('each TimerType should have correct properties', () {
      final focus = TimerType.focus;
      expect(focus.minutes, 25);
      expect(focus.title, 'Modo Foco');
      expect(focus.imageName, 'assets/focus.png');

      final shortBreak = TimerType.shortBreak;
      expect(shortBreak.minutes, 5);
      expect(shortBreak.title, 'Pausa Curta');
      expect(shortBreak.imageName, 'assets/pause.png');

      final longBreak = TimerType.longBreak;
      expect(longBreak.minutes, 15);
      expect(longBreak.title, 'Pausa Longa');
      expect(longBreak.imageName, 'assets/long.png');
    });
  });
}