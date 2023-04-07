class Notice {
  String? id;
  String? title;
  String? description;
  String? image;

  Notice({this.id, this.title, this.description, this.image});

  Notice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
  }
}
