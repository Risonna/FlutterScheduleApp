import '../../domain/entities/User.dart';

abstract class IAuthorizationSender{
  Future<String> sendUser(User user, String endpoint);
}