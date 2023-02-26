class Membership {
  final String id;
  final String name;
  final String cpf;
  final String address;
  final String plate;
  final String accessProfileFk;

  Membership(
      {required this.id,
      required this.name,
      required this.cpf,
      required this.address,
      required this.plate,
      required this.accessProfileFk});

  factory Membership.fromJson(Map<String, dynamic> json) {
    return Membership(
        id: json['id'],
        name: json['name'],
        cpf: json['cpf'],
        address: json['address'],
        plate: json['plate'],
        accessProfileFk: json['accessProfileFk']);
  }
}
