class Training {
  String? id;
  String name;
  Training({this.id, required this.name});

  factory Training.fromJson(Map<String, dynamic> json) {
    return Training(id: json["id"], name: json["name"]);
  }
}
