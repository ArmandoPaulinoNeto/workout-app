class LoadingDataExercise {
  String? id;
  String? name;
  String? muscleGroup;

  LoadingDataExercise({this.id, this.name, this.muscleGroup});

  LoadingDataExercise.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    muscleGroup = json['muscle_group'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['muscle_group'] = this.muscleGroup;
    return data;
  }
}
