import 'package:workout_app/app/repositories/training_repository.dart';

class TrainingService {
  TrainingRepository trainingRepository = TrainingRepository();

  fetchAllTraining(String token) {
    return trainingRepository.fetchAllTraining(token);
  }
}
