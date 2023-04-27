import '../repositories/administrator_repository.dart';

class SignupAdministratorService {
  createTeacher(String cref, String name, String birthday, String sex,
      String photo, String email, String password, String role, String token) {
    AdministratorRepository administratorRepository = AdministratorRepository();
    var dataTeacher = {
      "cref": cref,
      "name": name,
      "birthday": birthday,
      "sex": sex,
      "email": email,
      "password": password,
      "photo": photo,
      "role": role
    };
    return administratorRepository.saveTeacher(dataTeacher, token);
  }

  createExecise(String name, String muscleGroup, String token) {
    AdministratorRepository administratorRepository = AdministratorRepository();
    var dataExercise = {"name": name, "muscleGroup": muscleGroup};

    return administratorRepository.seveExercise(dataExercise, token);
  }
}
