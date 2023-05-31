class Pupil {
  String? id;
  String? name;
  String? birthday;
  String? sex;
  String? accessFk;
  String? email;
  String? password;
  String? profileFk;
  String? photo;
  String? role;
  String? goal;
  String? personFk;
  String? lastTraining;
  String? weight;
  String? hight;

  Pupil(
      {this.id,
      this.name,
      this.birthday,
      this.sex,
      this.accessFk,
      this.email,
      this.password,
      this.profileFk,
      this.photo,
      this.role,
      this.goal,
      this.personFk,
      this.weight,
      this.hight,
      this.lastTraining});

  Pupil.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    birthday = json['birthday'];
    sex = json['sex'];
    accessFk = json['access_fk'];
    email = json['email'];
    password = json['password'];
    profileFk = json['profile_fk'];
    photo = json['photo'];
    goal = json['goal'];
    personFk = json['person_fk'];
    weight = json['current_weight'];
    hight = json['hight'];
    lastTraining = json['last_training'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['birthday'] = this.birthday;
    data['sex'] = this.sex;
    data['access_fk'] = this.accessFk;
    data['email'] = this.email;
    data['password'] = this.password;
    data['profile_fk'] = this.profileFk;
    data['photo'] = this.photo;
    if (this.role != null) {
      data['role'] = this.role;
    }
    data['goal'] = this.goal;
    data['person_fk'] = this.personFk;
    return data;
  }
}
