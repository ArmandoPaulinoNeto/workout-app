import 'package:workout_app/app/repositories/user_repository.dart';

class SigninService {
  UserRepository userRepository = UserRepository();

  signinUser(String emailOrUsername, String password) {
    return userRepository.signinAccessToken(emailOrUsername, password);
  }
}
