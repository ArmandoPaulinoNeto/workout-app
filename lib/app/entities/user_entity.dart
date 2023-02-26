class User {
  String id;
  String username;
  String email;
  String password;
  String membershipFk;

  User(
      {required this.id,
      required this.username,
      required this.email,
      required this.password,
      required this.membershipFk});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        username: json['username'],
        email: json['email'],
        password: json['password'],
        membershipFk: json['membership_fk']);
  }
}
