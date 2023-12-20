import 'dart:convert';

import 'package:flutter_test_scheduler/blogic/requests/globalUrl.dart';
import 'package:flutter_test_scheduler/blogic/requests/interfaces/IAuthorizationSender.dart';
import 'package:http/http.dart' as http;

import '../../domain/entities/User.dart';

class AuthorizationSender implements IAuthorizationSender{
  @override
  sendUser(User user, String endpoint) async {
    try {
      print('Request Payload: ${json.encode(user)}');
      if(endpoint =='login') {
        print('Request Payload for login is ${user.toJson()}');
        final response = await http.post(Uri.parse('http://${globalUrl}api/auth/$endpoint'),
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
        print('Request Payload For registration is ${user.toJsonRegister()}');
        final response = await http.post(Uri.parse('http://${globalUrl}api/auth/$endpoint'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode(user.toJsonRegister()));

        if (response.statusCode == 200) {

          print('Returned response 200');
        } else {
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