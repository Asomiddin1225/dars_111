import 'package:recipe_app/data/models/user/user.dart';
import 'package:recipe_app/data/services.dart/user_service.dart';

class UserRepository {
  final UserService userService;

  UserRepository({
    required this.userService,
  });

  Future<User> getUser() async {
    return await userService.getUser();
  }
}