import 'package:flutter/cupertino.dart';

import '../../../blogic/domain/entities/Teacher.dart';
import '../../../blogic/requests/requesters/TeacherRequester.dart';

class TeacherModel with ChangeNotifier {
  String selectedTeacher = 'Завозкин С.Ю.';
  List<String> _teachers = [];
  bool _isLoading = false;
  String? _error;

  List<String> get teachers{
    if(_teachers.isEmpty){
      fetchTeachers();
    }
    return _teachers;
  }
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchTeachers() async {
    _isLoading = true;
    notifyListeners();

    try {
      final teacherData = await TeacherRequester().requestTeachers();
      // Transform data if necessary
      for (Teacher teacher in teacherData) {
        if (teacher.teacherPatronymic != "unknown" && teacher.teacherSurname != "unknown") {
          _teachers.add("${teacher.teacherSurname} ${teacher.teacherName.substring(0, 1)}.${teacher.teacherPatronymic.substring(0, 1)}.");
        } else {
          _teachers.add(teacher.teacherName);
        }
      }
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  void updateSelectedTeacher(String teacher) {
    selectedTeacher = teacher;
    notifyListeners();
  }
}