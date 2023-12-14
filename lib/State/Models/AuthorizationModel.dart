import 'package:flutter/cupertino.dart';
import 'package:flutter_test_scheduler/blogic/requests/senders/LoginSender.dart';
import 'package:flutter_test_scheduler/blogic/requests/senders/RegisterSender.dart';

import '../../blogic/domain/entities/User.dart';
import 'dart:convert';

class AuthorizationModel with ChangeNotifier {
  String _token = 'empty';
  bool _isLoading = false;
  String? _error;
  String role = 'guest';
  String _username = '';

  String get token{
    print(_token);
    return _token;
  }

  bool get isLoading => _isLoading;
  String? get error => _error;
  String get username => _username;

  void setUsername(String username){
    this._username = username;
  }

  Future<void> loginUser(User user) async {
    _isLoading = true;
    _token = 'empty';
    notifyListeners();

    try {

      final response = await LoginSender().loginUser(user);

      _token = response;
      print('token is ' + _token);

      role = parseJwt(token!)['role'];
      print('role is ' + role);


    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      setUsername(user.username);
      notifyListeners();
    }
  }

  Future<void> registerUser(User user) async {
    _isLoading = true;
    notifyListeners();

    try {
      await RegisterSender().registerUser(user);

      loginUser(user);

    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }

  }

  Map<String, dynamic> parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }

    return payloadMap;
  }

  String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }

  void logoutUser(){
    _token = 'empty';
    role = 'guest';
    notifyListeners();
  }


}
