import 'blogic/domain/entities/Cabinet.dart';
import 'blogic/domain/entities/Group.dart';
import 'blogic/domain/entities/Lesson.dart';
import 'blogic/domain/entities/Subject.dart';
import 'blogic/domain/entities/Teacher.dart';
import 'blogic/requests/requesters/CabinetRequester.dart';
import 'blogic/requests/requesters/GroupRequester.dart';
import 'blogic/requests/requesters/LessonRequester.dart';
import 'blogic/requests/requesters/Requester.dart';
import 'blogic/requests/requesters/SubjectRequester.dart';
import 'blogic/requests/requesters/TeacherRequester.dart';

void main() async {
  print("hello world!");

 //  TeacherRequester teacherRequester = TeacherRequester();
 //  List<Teacher> teachers = await teacherRequester.requestTeachers("get-all-teachers");
 //
 //
 // for(Teacher teacher in teachers){
 //   print(teacher.teacherId);
 //   print("${teacher.teacherSurname} ${teacher.teacherName} ${teacher.teacherPatronymic}");
 //   print(teacher.runtimeType);
 //   print("--------------------");
 // } // Now this will print the content of 'objects'

  // SubjectRequester subjectRequester = SubjectRequester();
  // List<Subject> subjects = await subjectRequester.requestSubjects("get-all-subjects");
  //
  //
  // for(Subject subject in subjects){
  //   print(subject.subjectName);
  //   print(subject.subjectId);
  //   print("-----------");
  // }

  // CabinetRequester cabinetRequester = CabinetRequester();
  // List<Cabinet> cabinets = await cabinetRequester.requestCabinets("get-all-cabinets");
  //
  // for(Cabinet cabinet in cabinets){
  //   print(cabinet.cabinetName);
  //   print(cabinet.cabinetId);
  //   print("------------");
  // }

  // GroupRequester groupRequester = GroupRequester();
  // List<Group> groups = await groupRequester.requestGroups("get-all-groups");
  //
  // for(Group group in groups){
  //   print(group.groupId);
  //   print(group.groupName);
  //   print("-----------");
  // }

  // LessonRequester lessonRequester = LessonRequester();
  // List<Lesson> listOfLessons = await lessonRequester.requestLessons("get-all-lessons");
  //
  // for(Lesson lesson in listOfLessons){
  //   print(lesson.teacherName);
  //   print(lesson.cabinetName);
  //   print(lesson.subjectName);
  //   print(lesson.groupName);
  //   print("_______________________________");
  // }


}
