import 'package:workout_app/app/repositories/pupil_repository.dart';

class PupilService {
  PupilRepository pupilRepository = PupilRepository();

  fetchAllPupil(String token) {
    return pupilRepository.fetchAllPupil(token);
  }
}
