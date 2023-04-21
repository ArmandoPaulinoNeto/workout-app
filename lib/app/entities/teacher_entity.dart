class Teacher {
  String id;
  String cref;
  String personFK;

  Teacher({required this.id, required this.cref, required this.personFK});

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
        id: json['id'], cref: json['cref'], personFK: json['person_fk']);
  }
}
