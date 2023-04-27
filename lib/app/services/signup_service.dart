import 'package:workout_app/app/repositories/pupil_repository.dart';
import '../repositories/administrator_repository.dart';

class SignupService {
  createPupil(String goal, String name, String birthday, String sex,
      String photo, String email, String password, String role, String token) {
    PupilRepository pupilRepository = PupilRepository();
    var dataPupil = {
      "goal": goal,
      "name": name,
      "birthday": birthday,
      "sex": sex,
      "email": email,
      "password": password,
      "photo": photo,
      "role": role
    };
    return pupilRepository.savePupil(dataPupil, token);
  }
}
