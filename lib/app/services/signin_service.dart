import 'package:workout_app/app/repositories/user_repository.dart';

class SigninService {
  UserRepository userRepository = UserRepository();

  signinUser(String email, String password) {
    return userRepository.signinAccessToken(email, password);
  }

  getDataHome(String token) {
    return userRepository.getDataUser(token);
  }
}
