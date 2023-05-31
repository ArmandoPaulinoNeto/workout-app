class Access {
  late String id;
  late String email;
  late String password;

  Access({required this.id, required this.email, required password});

  factory Access.fromJson(Map<String, dynamic> json) {
    return Access(
        id: json['id'], email: json['email'], password: json['password']);
  }
}
