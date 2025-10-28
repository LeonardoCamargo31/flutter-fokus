import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fokus/app/shared/enums/timer_type.dart';
import 'package:fokus/app/view/pages/timer_page.dart';
import 'package:fokus/app/view_model/timer_view_model.dart';
import 'package:provider/provider.dart';
import 'package:mocktail/mocktail.dart';

class MockTimerViewModel extends Mock implements TimerViewModel {}

void main() {
  late MockTimerViewModel mockTimerViewModel;
  
  Widget makeSut({
    TimerType timerType = TimerType.focus,
  }) {
    return ChangeNotifierProvider<TimerViewModel>.value(
      value: mockTimerViewModel, // set mock in the provider
      child: MaterialApp(
        home: Scaffold(
          body: TimerPage(timerType: timerType),
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

  group('Time page UI', () {
    group('Time type - focus', () {
      testWidgets('should display initial timer and button start', (WidgetTester tester) async {
        await tester.pumpWidget(makeSut());

        expect(find.text('00:00'), findsOneWidget);
        expect(find.text('Iniciar'), findsOneWidget);
      });

      testWidgets('should call startTime when click button start', (WidgetTester tester) async {
        await tester.pumpWidget(makeSut());

        await tester.tap(find.text('Iniciar'));
        await tester.pumpAndSettle();

        verify(() => mockTimerViewModel.startTimer(25, any())).called(1);
      });

      testWidgets('should display pause button after start timer',  (WidgetTester tester) async {
        await tester.pumpWidget(makeSut());

        await tester.tap(find.text('Iniciar'));
        await tester.pumpAndSettle();

        tester.runAsync(() async {
          expect(find.text('Pausar'), findsOneWidget);
          expect(find.text('Iniciar'), findsNothing);
        });
      });

      testWidgets('should display "Continuar" button after pause timer',  (WidgetTester tester) async {
        await tester.pumpWidget(makeSut());

        await tester.tap(find.text('Iniciar'));
        await tester.pumpAndSettle();

        tester.runAsync(() async {
          await tester.tap(find.text('Pausar'));
          await tester.pumpAndSettle();

          expect(find.text('Continuar'), findsOneWidget);
        });
      });

      testWidgets('should call stopTimer when click button stop',  (WidgetTester tester) async {
        await tester.pumpWidget(makeSut());

        await tester.tap(find.text('Iniciar'));
        await tester.pumpAndSettle();

        tester.runAsync(() async {
          expect(find.text('Parar'), findsOneWidget);
          await tester.tap(find.text('Pausar'));
          await tester.pumpAndSettle();

          verify(() => mockTimerViewModel.stopTimer()).called(1);
        });
      });
    });

    group('Time type - longBreak', () {
      testWidgets('should display initial timer and button start', (WidgetTester tester) async {
        await tester.pumpWidget(makeSut(timerType: TimerType.longBreak));

        expect(find.text('00:00'), findsOneWidget);
        expect(find.text('Iniciar'), findsOneWidget);
      });

      testWidgets('should call startTime when click button start', (WidgetTester tester) async {
        await tester.pumpWidget(makeSut(timerType: TimerType.longBreak));

        await tester.tap(find.text('Iniciar'));
        await tester.pumpAndSettle();

        verify(() => mockTimerViewModel.startTimer(15, any())).called(1);
      });

      testWidgets('should display pause button after start timer',  (WidgetTester tester) async {
        await tester.pumpWidget(makeSut(timerType: TimerType.longBreak));

        await tester.tap(find.text('Iniciar'));
        await tester.pumpAndSettle();

        tester.runAsync(() async {
          expect(find.text('Pausar'), findsOneWidget);
          expect(find.text('Iniciar'), findsNothing);
        });
      });

      testWidgets('should display "Continuar" button after pause timer',  (WidgetTester tester) async {
        await tester.pumpWidget(makeSut());

        await tester.tap(find.text('Iniciar'));
        await tester.pumpAndSettle();

        tester.runAsync(() async {
          await tester.tap(find.text('Pausar'));
          await tester.pumpAndSettle();

          expect(find.text('Continuar'), findsOneWidget);
        });
      });

      testWidgets('should call stopTimer when click button stop',  (WidgetTester tester) async {
        await tester.pumpWidget(makeSut(timerType: TimerType.longBreak));

        await tester.tap(find.text('Iniciar'));
        await tester.pumpAndSettle();

        tester.runAsync(() async {
          expect(find.text('Parar'), findsOneWidget);
          await tester.tap(find.text('Pausar'));
          await tester.pumpAndSettle();

          verify(() => mockTimerViewModel.stopTimer()).called(1);
        });
      });
    });

    group('Time type - shortBreak', () {
      testWidgets('should display initial timer and button start', (WidgetTester tester) async {
        await tester.pumpWidget(makeSut(timerType: TimerType.shortBreak));

        expect(find.text('00:00'), findsOneWidget);
        expect(find.text('Iniciar'), findsOneWidget);
      });

      testWidgets('should call startTime when click button start', (WidgetTester tester) async {
        await tester.pumpWidget(makeSut(timerType: TimerType.shortBreak));

        await tester.tap(find.text('Iniciar'));
        await tester.pumpAndSettle();

        verify(() => mockTimerViewModel.startTimer(5, any())).called(1);
      });

      testWidgets('should display pause button after start timer',  (WidgetTester tester) async {
        await tester.pumpWidget(makeSut(timerType: TimerType.shortBreak));

        await tester.tap(find.text('Iniciar'));
        await tester.pumpAndSettle();

        tester.runAsync(() async {
          expect(find.text('Pausar'), findsOneWidget);
          expect(find.text('Iniciar'), findsNothing);
        });
      });

      testWidgets('should display "Continuar" button after pause timer',  (WidgetTester tester) async {
        await tester.pumpWidget(makeSut());

        await tester.tap(find.text('Iniciar'));
        await tester.pumpAndSettle();

        tester.runAsync(() async {
          await tester.tap(find.text('Pausar'));
          await tester.pumpAndSettle();

          expect(find.text('Continuar'), findsOneWidget);
        });
      });

      testWidgets('should call stopTimer when click button stop',  (WidgetTester tester) async {
        await tester.pumpWidget(makeSut(timerType: TimerType.shortBreak));

        await tester.tap(find.text('Iniciar'));
        await tester.pumpAndSettle();

        tester.runAsync(() async {
          expect(find.text('Parar'), findsOneWidget);
          await tester.tap(find.text('Pausar'));
          await tester.pumpAndSettle();

          verify(() => mockTimerViewModel.stopTimer()).called(1);
        });
      });
    });
  });
}