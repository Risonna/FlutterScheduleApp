import 'dart:convert';

import 'package:flutter_test_scheduler/blogic/requests/interfaces/IAuthorizationSender.dart';
import 'package:http/http.dart' as http;

import '../../domain/entities/User.dart';

class AuthorizationSender implements IAuthorizationSender{
  String baseUrl = "http://localhost:8080/ScheduleWebApp-1.0-SNAPSHOT/api/auth";
  String baseUrlAndroid = "http://10.0.2.2:8080/ScheduleWebApp-1.0-SNAPSHOT/api/auth";
  @override
  sendUser(User user, String endpoint) async {
    try {
      print('Request Payload: ${json.encode(user)}');
      if(endpoint =='login') {
        final response = await http.post(Uri.parse('$baseUrlAndroid/$endpoint'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode(user));

        if (response.statusCode == 200) {
          final Map<String, dynamic> jsonResponse = json.decode(response.body);

          // Check if the response has a 'token' field
          if (jsonResponse.containsKey('token')) {
            return jsonResponse['token'];
          } else {
            throw Exception('Invalid response format: $jsonResponse');
          }
        } else {
          print('HTTP request failed with status ${response.statusCode}');
          print('Response body: ${response.body}');
          throw Exception('Failed to send user');
        }
      }
      else if(endpoint == 'register'){
        final response = await http.post(Uri.parse('$baseUrlAndroid/$endpoint'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode(user.toJsonRegister()));

        if (response.statusCode == 200) {
          final Map<String, dynamic> jsonResponse = json.decode(response.body);

          // Check if the response has a 'token' field
          if (jsonResponse.containsKey('token')) {
            return jsonResponse['token'];
          } else {
            throw Exception('Invalid response format: $jsonResponse');
          }
        } else {
          // Handle error cases here, for example:
          print('HTTP request failed with status ${response.statusCode}');
          print('Response body: ${response.body}');
          throw Exception('Failed to send user');
        }
      }
      return 'error';
    } catch (e) {
      print('Exception caught: $e');
      throw Exception('Failed to send user: $e');
    }
  }
}