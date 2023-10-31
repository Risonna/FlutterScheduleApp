import '../../domain/entities/Cabinet.dart';
import '../../domain/entities/Group.dart';
import '../../domain/entities/Lesson.dart';
import '../../domain/entities/Subject.dart';
import '../../domain/entities/Teacher.dart';
import 'CabinetRequester.dart';
import 'GroupRequester.dart';
import 'Requester.dart';
import 'SubjectRequester.dart';
import 'TeacherRequester.dart';

class LessonRequester extends Requester{
  LessonRequester();
  late List<Group> listOfGroups;
  late List<Teacher> listOfTeachers;
  late List<Cabinet> listOfCabinets;
  late List<Subject> listOfSubjects;
  bool groupListInitialized = false;
  bool teacherListInitialized = false;
  bool subjectListInitialized = false;
  bool cabinetListInitialized = false;

  Future<List<Lesson>> requestLessons() async{
    Requester requester = Requester();
    dynamic objects = await requester.requestObjects("get-all-lessons");
    if(!groupListInitialized){
      listOfGroups = await GroupRequester().requestGroups("get-all-groups");
      groupListInitialized = true;
    }
    if(!teacherListInitialized){
      listOfTeachers = await TeacherRequester().requestTeachers("get-all-teachers");
      teacherListInitialized = true;
    }
    if(!cabinetListInitialized){
      listOfCabinets = await CabinetRequester().requestCabinets("get-all-cabinets");
      cabinetListInitialized = true;
    }
    if(!subjectListInitialized){
      listOfSubjects = await SubjectRequester().requestSubjects("get-all-subjects");
      subjectListInitialized = true;
    }

    List<Lesson> lessons = [];

    for (dynamic lessonMap in objects) {
      Lesson lesson = Lesson.fromJson(lessonMap);
      lesson.subjectName = await subjectNameGetFromRequest(lesson.subjectId);
      lesson.groupName = await groupNameGetFromRequest(lesson.groupId);
      lesson.cabinetName = await cabinetNameGetFromRequest(lesson.cabinetId);
      lesson.teacherName = await teacherNameGetFromRequest(lesson.teacherId);
      lessons.add(lesson);
    }

    return lessons;
  }



  Future<String> groupNameGetFromRequest(int groupId) async {
    for(Group group in listOfGroups){
      if(group.groupId == groupId){
        return group.groupName;
      }
    }

    return "unknown";
  }

  Future<String> subjectNameGetFromRequest(int subjectId) async {
    for(Subject subject in listOfSubjects){
      if(subject.subjectId == subjectId){
        return subject.subjectName;
      }
    }

    return "unknown";
  }


  Future<String> cabinetNameGetFromRequest(int cabinetId) async {
    for(Cabinet cabinet in listOfCabinets){
      if(cabinet.cabinetId == cabinetId){
        return cabinet.cabinetName;
      }
    }
    return "unknown";
  }

  Future<String> teacherNameGetFromRequest(int teacherId) async {
    for(Teacher teacher in listOfTeachers){
      if(teacher.teacherId == teacherId){
        if(teacher.teacherPatronymic != "unknown" && teacher.teacherSurname != "unknown"){
          return teacher.teacherSurname + " " + teacher.teacherName.substring(0, 1) + "." + teacher.teacherPatronymic.substring(0, 1) + ".";
        }else{
          return teacher.teacherName;
        }
      }
    }
    return "unknown";
  }

}