import 'package:workout_app/app/repositories/signin_repository.dart';

class SigninService {
  SigninRepository signinRepository = SigninRepository();

  signinPerson(String email, String password) {
    return signinRepository.signinAccessToken(email, password);
  }

  getDataHomeAdministrator(String token) {
    return signinRepository.getDataAdministrator(token);
  }

  getDataHomePupil(String token) {
    return signinRepository.getDataHomePupil(token);
  }
}
