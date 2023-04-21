import 'package:workout_app/app/repositories/signin_repository.dart';

class SigninService {
  SigninRepository signinRepository = SigninRepository();

  signinPerson(String email, String password) {
    return signinRepository.signinAccessToken(email, password);
  }

  getDataHome(String token) {
    return signinRepository.getDataUser(token);
  }
}
