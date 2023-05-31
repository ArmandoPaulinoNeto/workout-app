class Exercise {
  String? id;
  String? name;
  String? muscleGroup;

  Exercise({this.id, this.name, this.muscleGroup});

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
        id: json['id'],
        name: json['name'] ?? json['e_name'],
        muscleGroup: json['muscle_group']);
  }
}
