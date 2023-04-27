import 'package:workout_app/app/repositories/administrator_repository.dart';

class AdministratorService {
  AdministratorRepository administratorRepository = AdministratorRepository();
  fetchAllTeacher(String token) {
    return administratorRepository.fetchAllTeacher(token);
  }

  fetchAllExercise(String token) {
    return administratorRepository.fetchAllExercise(token);
  }
}
