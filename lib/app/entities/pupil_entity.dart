class Pupil {
  String id;
  String goal;
  String personFK;

  Pupil({required this.id, required this.goal, required this.personFK});

  factory Pupil.fromJson(Map<String, dynamic> json) {
    return Pupil(
        id: json['id'], goal: json['goal'], personFK: json['person_fk']);
  }
}
