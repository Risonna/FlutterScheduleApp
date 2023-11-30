import 'package:flutter_test_scheduler/blogic/requests/senders/AuthorizationSender.dart';

import '../../domain/entities/User.dart';

class LoginSender extends AuthorizationSender{
  Future<String> loginUser(User user) async {
    final response = await sendUser(user, 'login');
    return response;
  }
}