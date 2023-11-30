import 'package:flutter/cupertino.dart';
import 'package:flutter_test_scheduler/blogic/requests/senders/AdminTeacherSender.dart';

class AdminsTeachersModel with ChangeNotifier {
  List<String> _adminsTeachers = [];
  bool _isLoading = false;
  String? _error;

  List<String> get adminsTeachers{
    return _adminsTeachers;
  }
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchAdminsTeachers() async {
    _isLoading = true;
    notifyListeners();
    List<String> fetchedAdminsTeachers = [];

    try {
      final cabinetData = await AdminTeacherSender().requestAdminsTeachers();


      for (String teacher in cabinetData) {
        fetchedAdminsTeachers.add(teacher);
      }
      _adminsTeachers = fetchedAdminsTeachers;
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addAdminTeacher(String adminTeacher, String token) async {
    print('token in addAdminTeacher in model is ' + token);
    _isLoading = true;
    notifyListeners();

    try {
      await AdminTeacherSender().sendAdminTeacher(adminTeacher, 'addTeacher', token).then((value) => fetchAdminsTeachers());

      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  Future<void> deleteAdminTeacher(String adminTeacher, String token) async {
    print('token in deleteAdminTeacher in model is ' + token);
    _isLoading = true;
    notifyListeners();

    try {
      print('deleteTeacher/$adminTeacher');
      await AdminTeacherSender().sendAdminTeacher(adminTeacher, 'deleteTeacher/$adminTeacher', token).then((value) => fetchAdminsTeachers());
      print('deleteTeacher/$adminTeacher');


      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

}
