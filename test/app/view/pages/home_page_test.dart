import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fokus/app/shared/utils/routes.dart';
import 'package:fokus/app/view/pages/home_page.dart';
import 'package:fokus/app/view/pages/timer_page.dart';
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
        routes: routes,
        home: Scaffold(body: HomePage()),
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

  group('Home page UI', () {
    group('Modo Foco', () {
      testWidgets('should list all methods and render buttons in page', (WidgetTester tester) async {
        await tester.pumpWidget(makeSut());

        expect(find.text('Modo Foco'), findsOneWidget);
        expect(find.text('Pausa Curta'), findsOneWidget);
        expect(find.text('Pausa Longa'), findsOneWidget);

        await tester.tap(find.text('Modo Foco'));
        await tester.pumpAndSettle();

        expect(find.byType(TimerPage), findsOneWidget);
        expect(find.byType(TimerWidget), findsOneWidget);
      });
    });

    group('Pausa Longa', () {
      testWidgets('should list all methods and render buttons in page', (WidgetTester tester) async {
        await tester.pumpWidget(makeSut());

        expect(find.text('Modo Foco'), findsOneWidget);
        expect(find.text('Pausa Curta'), findsOneWidget);
        expect(find.text('Pausa Longa'), findsOneWidget);

        await tester.tap(find.text('Pausa Longa'));
        await tester.pumpAndSettle();

        expect(find.byType(TimerPage), findsOneWidget);
        expect(find.byType(TimerWidget), findsOneWidget);
      });
    });

    group('Pausa Curta', () {
      testWidgets('should list all methods and render buttons in page', (WidgetTester tester) async {
        await tester.pumpWidget(makeSut());

        expect(find.text('Modo Foco'), findsOneWidget);
        expect(find.text('Pausa Curta'), findsOneWidget);
        expect(find.text('Pausa Longa'), findsOneWidget);

        await tester.tap(find.text('Pausa Curta'));
        await tester.pumpAndSettle();

        expect(find.byType(TimerPage), findsOneWidget);
        expect(find.byType(TimerWidget), findsOneWidget);
      });
    });
  });
}