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
  static List<String> daysOfWeek = ["понедельник", "вторник", "среда", "четверг", "пятница", "суббота", "воскресенье"];

  LessonTime({required this.lessonDay, required this.lessonTime, required this.lessonWeek});


  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LessonTime &&
        other.lessonDay == lessonDay &&
        other.lessonTime == lessonTime &&
        other.lessonWeek == lessonWeek;
  }

  @override
  int get hashCode => lessonDay.hashCode ^ lessonTime.hashCode ^ lessonWeek.hashCode;


}