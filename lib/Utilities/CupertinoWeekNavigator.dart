import 'package:flutter/cupertino.dart';

class CupertinoWeekNavigator {
  const CupertinoWeekNavigator({required this.context, required this.week});

  final BuildContext context;
  final int week;

  void toNextWeek() {
    _navigateToWeek(week + 1);
  }

  void toPreviousWeek() {
    _navigateToWeek(week - 1);
  }

  void toCurrentWeek() {
    _navigateToWeek(week);
  }

  void _navigateToWeek(int week) {
    Navigator.of(context).pushReplacementNamed('$week');
  }
}