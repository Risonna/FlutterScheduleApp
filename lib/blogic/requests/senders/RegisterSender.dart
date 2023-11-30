import 'package:flutter_test_scheduler/blogic/requests/senders/AuthorizationSender.dart';

import '../../domain/entities/User.dart';

class RegisterSender extends AuthorizationSender{
  Future<String> registerUser(User user) async {
    final response = await sendUser(user, 'register');
    return response;
  }
}