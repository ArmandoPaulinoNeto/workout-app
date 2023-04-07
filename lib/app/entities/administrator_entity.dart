class Administrator {
  String? id;
  String? name;
  String? accessfk;

  Administrator({this.id, this.name, this.accessfk});

  Administrator.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    accessfk = json['access_fk'];
  }
}
