import 'package:flutter_test_scheduler/blogic/domain/interfaces/entities/IUser.dart';

class User implements IUser {
  @override
  final String username; // <-- Match the field name
  @override
  final String password;
  late final String? passwordConfirm;
  late final String? email;

  User({
    required this.username, // <-- Match the field name
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username, // <-- Match the field name
      'password': password,
    };
  }

  Map<String, dynamic> toJsonRegister() {
    return {
      'name': username, // <-- Match the field name
      'password': password,
      'passwordConfirm': passwordConfirm,
      'email': email,
    };
  }
}
