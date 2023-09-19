import '../../domain/entities/Teacher.dart';
import 'Requester.dart';

class TeacherRequester extends Requester{
  TeacherRequester();

  Future<List<Teacher>> requestTeachers(String url) async {
    Requester requester = Requester();
    dynamic objects = await requester.requestObjects("get-all-teachers");

    List<Teacher> teachers = [];

    for (dynamic teacherMap in objects) {
      Teacher teacher = Teacher.fromJson(teacherMap);
      teachers.add(teacher);
    }

    return teachers;
  }




}