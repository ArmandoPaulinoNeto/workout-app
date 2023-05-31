import 'exercise_entity.dart';

class Schedule {
  String? id;
  bool? status;
  String? trainingDay;
  String? nameTraining;
  List<String>? repetitions;
  List<String>? series;
  List<String>? weight;
  List<String>? observations;
  String? trainingFK;
  List<String>? trainingExerciseFK;
  List<Exercise>? exercises;

  Schedule(
      {this.id,
      this.nameTraining,
      this.status,
      this.trainingDay,
      this.repetitions,
      this.series,
      this.weight,
      this.observations,
      this.trainingFK,
      this.trainingExerciseFK,
      this.exercises});

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
        id: json['id'],
        status: json['status'],
        nameTraining: json['name_training'],
        trainingDay: json['training_day'],
        repetitions: json['repetitions'],
        series: json['series'],
        weight: json['weight'],
        observations: json['observations'],
        exercises: json['exercises'],
        trainingFK: json['training_fk'],
        trainingExerciseFK: json['training_exercise_id']);
  }

  factory Schedule.fromListJson(List listJson) {
    return Schedule(
        nameTraining: listJson[0]['name_training'],
        trainingDay: listJson[0]['training_day'],
        repetitions: List.generate(
            listJson.length, (index) => listJson[index]['repetitions']),
        series: List.generate(
            listJson.length, (index) => listJson[index]['series']),
        weight: List.generate(
            listJson.length, (index) => listJson[index]['weight']),
        observations: List.generate(
            listJson.length, (index) => listJson[index]['observation']),
        exercises: List.generate(
            listJson.length, (index) => Exercise.fromJson(listJson[index])),
        trainingExerciseFK: List.generate(listJson.length,
            (index) => listJson[index]['training_exercise_id']));
  }
}
