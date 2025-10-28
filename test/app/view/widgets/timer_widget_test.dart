import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fokus/app/view/widgets/timer_widget.dart';
import 'package:fokus/app/view_model/timer_view_model.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

class MockTimerViewModel extends Mock implements TimerViewModel {}

void main() {
  late MockTimerViewModel mockTimerViewModel;

  Widget makeSut() {
    return ChangeNotifierProvider<TimerViewModel>.value(
      value: mockTimerViewModel, // set mock in the provider
      child: MaterialApp(
        home: Scaffold(
          body: TimerWidget(initialMinutes: 1),
        ),
      ),
    );
  }

  setUpAll(() {
    // register fallback value for ValueNotifier<bool>
    registerFallbackValue(ValueNotifier<bool>(false));
  });

  setUp(() {
    mockTimerViewModel = MockTimerViewModel();
    
    // need set default values for the mock
    when(() => mockTimerViewModel.isPlaying).thenReturn(false);
    when(() => mockTimerViewModel.duration).thenReturn(Duration.zero);
  });

  group('Timer Widget', () {
    testWidgets('should display time zero', (WidgetTester tester) async {
      await tester.pumpWidget(makeSut());
      expect(find.text('00:00'), findsOneWidget);
    });

    testWidgets('should play when call startTimer from TimerViewModel', (WidgetTester tester) async {
      await tester.pumpWidget(makeSut());

      final startButton = find.text('Iniciar');
      expect(startButton, findsOneWidget);

      await tester.tap(startButton);
      await tester.pumpAndSettle();

      // function from mocktail, verify that startTimer was called
      verify(() => mockTimerViewModel.startTimer(any(), any())).called(1);
    });

    testWidgets('should pause when call stopTimer from TimerViewModel', (WidgetTester tester) async {
      await tester.pumpWidget(makeSut());

      // start the timer first
      final startButton = find.text('Iniciar');
      expect(startButton, findsOneWidget);

      await tester.tap(startButton);
      await tester.pumpAndSettle();

      // async block to wait for timer ticks
      tester.runAsync(() async {
        // pause the timer
        final pauseButton = find.text('Pausar');
        expect(pauseButton, findsOneWidget);

        await tester.tap(pauseButton);
        await tester.pumpAndSettle(Duration(seconds: 2));

        verify(() => mockTimerViewModel.stopTimer()).called(1);
        expect(find.text("00:01"), findsOneWidget);
      });
    });

    testWidgets('should call stopTimer when click pause button', (WidgetTester tester) async {
      await tester.pumpWidget(makeSut());

      final startButton = find.text('Iniciar');
      expect(startButton, findsOneWidget);

      await tester.tap(startButton);
      await tester.pumpAndSettle();

      tester.runAsync(() async {
        final stopButton = find.text('Parar');
        expect(stopButton, findsOneWidget);

        await tester.tap(stopButton);
        await tester.pumpAndSettle();

        verify(() => mockTimerViewModel.stopTimer()).called(1);
      });
    });
  });
}
