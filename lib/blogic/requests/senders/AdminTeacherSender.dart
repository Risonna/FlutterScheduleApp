import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_test_scheduler/blogic/requests/interfaces/IAdminTeacherSender.dart';

class AdminTeacherSender implements IAdminTeacherSender {
  String baseUrl = "http://localhost:8080/ScheduleWebApp-1.0-SNAPSHOT/api/get-all-info";
  String baseUrlAndroid = "http://10.0.2.2:8080/ScheduleWebApp-1.0-SNAPSHOT/api/get-all-info";
  String baseUrlAndroidAdminsTeachers = "http://10.0.2.2:8080/ScheduleWebApp-1.0-SNAPSHOT/api/adminTeacher";


  @override
  Future<List<String>> requestAdminsTeachers() async {
    final url = Uri.parse('$baseUrlAndroid/get-all-admins-teachers');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the list of teachers
        final List<dynamic> data = jsonDecode(response.body);

        final List<String> adminTeachers =
        data.map((teacher) => teacher.toString()).toList();

        return adminTeachers;
      } else {
        // If the server did not return a 200 OK response,
        // throw an exception with the error message.
        throw Exception('Failed to load admin teachers');
      }
    } catch (error) {
      throw Exception('Error connecting to the server: $error');
    }
  }

  @override
  Future<void> sendAdminTeacher(String username, String endpoint, String token) async {
    try{
      if(endpoint == 'addTeacher'){
        print('token before sending is ' + token);
        final response = await http.post(Uri.parse('$baseUrlAndroidAdminsTeachers/$endpoint'),
            headers: {'Content-Type': 'application/json',
                      'Authorization' : token},
            body: username);
        if (response.statusCode == 200) {
          print('all ok');
        } else {
          print('HTTP request failed with status ${response.statusCode}');
          print('Response body: ${response.body}');
          throw Exception('Failed to send adminTeacher');
        }
      }
      else{
        print('token before sending is ' + token);

        final response = await http.delete(Uri.parse('$baseUrlAndroidAdminsTeachers/$endpoint'),
            headers: {'Authorization' : token});
        if (response.statusCode == 200) {
          print('all ok');
        } else {
          print('HTTP request failed with status ${response.statusCode}');
          print('Response body: ${response.body}');
          throw Exception('Failed to send adminTeacher');
        }
      }



    }
    catch(e){
      throw e;
    }
  }
}
