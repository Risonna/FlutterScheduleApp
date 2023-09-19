import '../entities/Lesson.dart';
import '../entities/LessonTime.dart';
import '../interfaces/ISorterer.dart';

class Sorterer extends ISorterer{






  @override
  int Count(String entity) {
    // TODO: implement Count
    throw UnimplementedError();
  }

  @override
  bool isFree(LessonTime lessonTime, String entity, List<Lesson> listOfLessons) {
   for(Lesson lesson in listOfLessons){
     if((lesson.teacherName?.toLowerCase() == entity.toLowerCase() || lesson.cabinetName?.toLowerCase() == entity.toLowerCase() || lesson.subjectName?.toLowerCase() == entity.toLowerCase() ||
         lesson.groupName?.toLowerCase() == entity.toLowerCase()) && lesson.lessonTime == lessonTime.lessonTime &&
         lesson.lessonWeek.toLowerCase() == lessonTime.lessonWeek &&lesson.lessonDay.toLowerCase() == lessonTime.lessonDay.toLowerCase()){
       return false;
     }
   }
   return true;
  }

  @override
  bool isNotFree(LessonTime lessonTime, String entity, List<Lesson> listOfLessons) {
    return !isFree(lessonTime, entity, listOfLessons);
  }

  @override
  String? whatLessonAt(LessonTime lessonTime, String entity, List<Lesson> listOfLessons) {
    for(Lesson lesson in listOfLessons){
      if((lesson.teacherName?.toLowerCase() == entity.toLowerCase() || lesson.cabinetName?.toLowerCase() == entity.toLowerCase() || lesson.subjectName?.toLowerCase() == entity.toLowerCase() ||
          lesson.groupName?.toLowerCase() == entity.toLowerCase()) && lesson.lessonTime == lessonTime.lessonTime &&
          lesson.lessonWeek.toLowerCase() == lessonTime.lessonWeek.toLowerCase() &&lesson.lessonDay.toLowerCase() == lessonTime.lessonDay.toLowerCase()){
        return lesson.subjectName!;
      }
    }
    return null;
  }

  @override
  List<LessonTime> whenLesson(String lessonId, String entity, List<Lesson> listOfLessons) {
    List<LessonTime> listOfLessonTimes = [];
    for(Lesson lesson in listOfLessons){
      if((lesson.teacherName?.toLowerCase() == entity || lesson.cabinetName?.toLowerCase() == entity || lesson.subjectName?.toLowerCase() == entity || lesson.groupName?.toLowerCase() == entity) && lesson.subjectName?.toLowerCase() == lessonId.toLowerCase()){
        LessonTime lessonTime = LessonTime(lessonDay: lesson.lessonDay.toLowerCase(), lessonTime: lesson.lessonTime, lessonWeek: lesson.lessonWeek.toLowerCase());
        listOfLessonTimes.add(lessonTime);
      }
    }
    return listOfLessonTimes;
  }

  @override
  List<LessonTime> whenNoLesson(String entity, List<Lesson> listOfLessons) {
    List<LessonTime> listOfLessonTimes = [];
    for (String lessonWeek in LessonTime.lessonWeeks) {
      for (String dayOfWeek in LessonTime.daysOfWeek) {
        for (String timePeriod in LessonTime.timePeriods) {
          listOfLessonTimes.add(LessonTime(
            lessonDay: dayOfWeek.toLowerCase(),
            lessonTime: timePeriod,
            lessonWeek: lessonWeek.toLowerCase(),
          ));
        }
      }
    }

    // Create a list of items to remove
    List<LessonTime> itemsToRemove = [];

    for (Lesson lesson in listOfLessons) {
      if (lesson.teacherName?.toLowerCase() == entity.toLowerCase() ||
          lesson.cabinetName?.toLowerCase() == entity.toLowerCase() ||
          lesson.subjectName?.toLowerCase() == entity.toLowerCase() ||
          lesson.groupName?.toLowerCase() == entity.toLowerCase()) {
        itemsToRemove.add(LessonTime(
          lessonDay: lesson.lessonDay.toLowerCase(),
          lessonTime: lesson.lessonTime,
          lessonWeek: lesson.lessonWeek.toLowerCase(),
        ));
      }
    }

    // Remove items
    listOfLessonTimes.removeWhere((lessonTime) => itemsToRemove.contains(lessonTime));

    return listOfLessonTimes;
  }


}