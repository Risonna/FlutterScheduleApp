import '../interfaces/entities/ILessonTime.dart';

class LessonTime implements ILessonTime{
  @override
  String lessonDay;

  @override
  String lessonTime;

  @override
  String lessonWeek;

  static List<String> timePeriods = ["8.00-9.35", "9.45-11.20", "11.45-13.20", "13.30-15.05", "15.30-17.05", "17.15-18.50", "19.00-20.35"];
  static List<String> lessonWeeks = ["", "чет", "неч"];
  static List<String> daysOfWeek = ["ПОНЕДЕЛЬНИК", "ВТОРНИК", "СРЕДА", "ЧЕТВЕРГ", "ПЯТНИЦА", "СУББОТА", "ВОСКРЕСЕНЬЕ"];

  LessonTime({required this.lessonDay, required this.lessonTime, required this.lessonWeek});

}