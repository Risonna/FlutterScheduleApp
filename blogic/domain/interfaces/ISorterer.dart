import '../entities/Lesson.dart';
import '../entities/LessonTime.dart';

abstract class ISorterer{
  int Count(String entity);
  bool isFree(LessonTime lessonTime, String entity, List<Lesson> listOfLessons);
  bool isNotFree(LessonTime lessonTime, String entity, List<Lesson> listOfLessons);
  String? whatLessonAt(LessonTime lessonTime, String entity, List<Lesson> listOfLessons);
  List<LessonTime> whenLesson(String lessonId, String entity, List<Lesson> listOfLessons);
  List<LessonTime> whenNoLesson(String entity, List<Lesson> listOfLessons);

}