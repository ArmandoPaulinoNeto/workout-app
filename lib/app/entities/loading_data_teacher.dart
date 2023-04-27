class LoadingDataTeacher {
  String? id;
  String? cref;
  String? personFk;
  String? name;

  LoadingDataTeacher({this.id, this.cref, this.personFk, this.name});

  LoadingDataTeacher.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cref = json['cref'];
    personFk = json['person_fk'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cref'] = this.cref;
    data['person_fk'] = this.personFk;
    data['name'] = this.name;
    return data;
  }
}
