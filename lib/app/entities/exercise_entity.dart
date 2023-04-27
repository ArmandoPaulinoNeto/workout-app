class Exercise {
  String id;
  String name;
  String muscleGroup;

  Exercise({required this.id, required this.name, required this.muscleGroup});

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
        id: json['id'], name: json['name'], muscleGroup: json['muscle_group']);
  }
}
