import 'package:workout_app/app/entities/assessment_entity.dart';
import 'package:workout_app/app/entities/pupil_entity.dart';
import 'package:workout_app/app/repositories/pupil_repository.dart';

class PupilService {
  PupilRepository pupilRepository = PupilRepository();

  fetchAllPupil(String token) {
    return pupilRepository.fetchAllPupil(token);
  }

  findById(String id, String token) {
    return pupilRepository.findById(id, token);
  }

  updatePupil(
      String id,
      String goal,
      String personFk,
      String name,
      String birthday,
      String sex,
      String accessFk,
      String photo,
      String email,
      String password,
      String profileFk,
      String token) {
    Pupil pupil = Pupil();
    pupil.id = id;
    pupil.name = name;
    pupil.birthday = birthday;
    pupil.sex = sex;
    pupil.accessFk = accessFk;
    pupil.email = email;
    pupil.password = password;
    pupil.profileFk = profileFk;
    pupil.photo = photo;
    pupil.goal = goal;
    pupil.personFk = personFk;
    return pupilRepository.updatePupil(pupil, token);
  }

  getSchedulePupil(String token) {
    return pupilRepository.getSchedulePupil(token);
  }

  deletePupil(String id, String token) {
    return pupilRepository.deletePupil(id, token);
  }

  findByScheduleId(scheduleId, String token) {
    return pupilRepository.findByScheduleId(scheduleId, token);
  }

  fetchAllAssessmentByPupilId(String token) {
    return pupilRepository.fetchAllAssessmentByPupilId(token);
  }

  updateTrainingPupil(String id, String weight, String token) {
    return pupilRepository.updateTrainingPupil(id, weight, token);
  }
}
