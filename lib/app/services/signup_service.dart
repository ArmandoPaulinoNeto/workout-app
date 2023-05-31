import 'package:workout_app/app/repositories/pupil_repository.dart';
import '../repositories/schedule_repository.dart';
import '../repositories/training_repository.dart';

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

  createTraining(String name, String token) async {
    TrainingRepository trainingRepository = TrainingRepository();
    var dataTraining = {
      "name": name,
    };
    return await trainingRepository.saveTraining(dataTraining, token);
  }

  createSchedule(
      String pupilFK,
      String trainingDay,
      String scheduledBy,
      List<String> repetitions,
      List<String> series,
      List<String> weight,
      List<String> observations,
      String trainingFK,
      List<String> exercisesFK,
      String token) async {
    ScheduleRepository scheduleRepository = ScheduleRepository();

    var dataSchedule = {
      "pupilFK": pupilFK,
      "trainingDay": trainingDay,
      "scheduledBy": scheduledBy,
      "repetitions": repetitions,
      "series": series,
      "weight": weight,
      "observations": observations,
      "trainingFK": trainingFK,
      "exercisesFK": exercisesFK
    };

    return await scheduleRepository.saveSchedule(dataSchedule, token);
  }
}
