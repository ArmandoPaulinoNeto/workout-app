import '../entities/assessment_entity.dart';
import '../repositories/administrator_repository.dart';

class SignupAdministratorService {
  AdministratorRepository administratorRepository = AdministratorRepository();

  createTeacher(String cref, String name, String birthday, String sex,
      String photo, String email, String password, String role, String token) {
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
    var dataExercise = {"name": name, "muscleGroup": muscleGroup};

    return administratorRepository.seveExercise(dataExercise, token);
  }

  Future<String> createAssessment(
      String weight,
      String hight,
      String subscapularis,
      String bicipital,
      String thickness,
      String midaxillary,
      String suprailiac,
      String breastplate,
      String abdominal,
      String thigh,
      String calf,
      String fatIdeal,
      String currentFat,
      String fatMass,
      String leanMass,
      String pupilId,
      String bmi,
      String token) {
    Assessment assessment = Assessment();

    var dataAssessment = {
      "weight": weight,
      "hight": hight,
      "subscapularis": subscapularis,
      "bicipital": bicipital,
      "thickness": thickness,
      "midaxillary": midaxillary,
      "suprailiac": suprailiac,
      "breastplate": breastplate,
      "abdominal": abdominal,
      "thigh": thigh,
      "calf": calf,
      "fatIdeal": fatIdeal,
      "currentFat": currentFat,
      "fatMass": fatMass,
      "leanMass": leanMass,
      "pupilFK": pupilId,
      "bmi": bmi
    };
    return administratorRepository.saveAssessment(dataAssessment, token);
  }
}
