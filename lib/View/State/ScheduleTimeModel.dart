import 'package:flutter/material.dart';

import '../../blogic/domain/entities/LessonTime.dart';

class ScheduleTimeModel with ChangeNotifier {

  static List<String> lessonWeeksOddEven = ["чет", "неч"];
  String selectedDay = LessonTime.daysOfWeek[0];
  String selectedWeek = lessonWeeksOddEven[0];

  void updateSelectedDay(String day) {
    selectedDay = day;
    notifyListeners();
  }

  void updateSelectedWeek(String week) {
    selectedWeek = week;
    notifyListeners();
  }
}
