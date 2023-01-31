import 'package:flutter/material.dart';

class MaterialWeekNavigator {
  const MaterialWeekNavigator({required this.context, required this.week});

  final BuildContext context;
  final int week;

  void toNextWeek() {
    _navigateToWeek(week + 1);
  }

  void toPreviousWeek() {
    _navigateToWeek(week - 1);
  }

  void _navigateToWeek(int week) {
    Navigator.of(context).pushReplacementNamed('$week');
  }
}