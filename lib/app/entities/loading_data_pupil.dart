class LoadingDataPupil {
  String? id;
  String? name;
  String? lastTraining;

  LoadingDataPupil({this.id, this.lastTraining, this.name});

  LoadingDataPupil.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lastTraining = json['last_training'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['last_training'] = this.lastTraining;
    return data;
  }
}
