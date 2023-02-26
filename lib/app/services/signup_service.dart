import 'package:workout_app/app/repositories/user_repository.dart';

class SignupService {
  UserRepository userRepository = UserRepository();

  findUserByPlateCpf(String plate, String cpf) {
    return userRepository.firstAccess(plate, cpf);
  }
}
