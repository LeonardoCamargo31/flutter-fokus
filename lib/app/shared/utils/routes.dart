import 'package:flutter/material.dart';
import 'package:fokus/app/shared/enums/timer_type.dart';
import 'package:fokus/app/view/pages/home_page.dart';
import 'package:fokus/app/view/pages/timer_page.dart';

Map<String, Widget Function(BuildContext)> routes = <String, WidgetBuilder>{
  '/home': (context) => const HomePage(),
  '/timer': (context) {
    final timerType = ModalRoute.of(context)!.settings.arguments as TimerType?;
    return TimerPage(timerType: timerType ?? TimerType.focus);
  },
};