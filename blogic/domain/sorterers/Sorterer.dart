import '../entities/Lesson.dart';
import '../entities/LessonTime.dart';
import '../interfaces/ISorterer.dart';

class SortererCabinet extends ISorterer{






  @override
  int Count(String entity) {
    // TODO: implement Count
    throw UnimplementedError();
  }

  @override
  bool isFree(LessonTime lessonTime, String entity, List<Lesson> listOfLessons) {
   for(Lesson lesson in listOfLessons){
     if((lesson.teacherName == entity || lesson.cabinetName == entity || lesson.subjectName == entity || lesson.groupName == entity) && lesson.lessonTime == lessonTime.lessonTime &&
         lesson.lessonWeek == lessonTime.lessonWeek &&lesson.lessonDay == lessonTime.lessonDay){
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
      if((lesson.teacherName == entity || lesson.cabinetName == entity || lesson.subjectName == entity || lesson.groupName == entity) && lesson.lessonTime == lessonTime.lessonTime &&
          lesson.lessonWeek == lessonTime.lessonWeek &&lesson.lessonDay == lessonTime.lessonDay){
        return lesson.subjectName!;
      }
    }
    return null;
  }

  @override
  List<LessonTime> whenLesson(String lessonId, String entity, List<Lesson> listOfLessons) {
    List<LessonTime> listOfLessonTimes = [];
    for(Lesson lesson in listOfLessons){
      if((lesson.teacherName == entity || lesson.cabinetName == entity || lesson.subjectName == entity || lesson.groupName == entity) && lesson.subjectName == lessonId){
        LessonTime lessonTime = LessonTime(lessonDay: lesson.lessonDay, lessonTime: lesson.lessonTime, lessonWeek: lesson.lessonWeek);
        listOfLessonTimes.add(lessonTime);
      }
    }
    return listOfLessonTimes;
  }

  @override
  List<LessonTime> whenNoLesson(String entity, List<Lesson> listOfLessons) {
    List<LessonTime> listOfLessonTimes = [];
    for(String lessonWeek in LessonTime.lessonWeeks){
      for(String dayOfWeek in LessonTime.daysOfWeek){
        for(String timePeriod in LessonTime.timePeriods){
          listOfLessonTimes.add(LessonTime(lessonDay: dayOfWeek, lessonTime: timePeriod, lessonWeek: lessonWeek));
        }
      }
    }
    for(Lesson lesson in listOfLessons){
      if((lesson.teacherName == entity || lesson.cabinetName == entity || lesson.subjectName == entity || lesson.groupName == entity)){
        listOfLessonTimes.remove(LessonTime(lessonDay: lesson.lessonDay, lessonTime: lesson.lessonTime, lessonWeek: lesson.lessonWeek));
      }
    }
    return listOfLessonTimes;
  }

}