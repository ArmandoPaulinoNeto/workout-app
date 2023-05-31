import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:workout_app/app/entities/pupil_entity.dart';
import 'package:workout_app/app/entities/teacher_entity.dart';

import 'administrator_entity.dart';

class PersonLogged {
  Administrator? administrator;
  Teacher? teacher;
  Pupil? pupil;
  String token;
  String? role;
  String? personId;
  PersonLogged(
      {this.administrator, this.teacher, this.pupil, required this.token}) {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    personId = decodedToken['sub'];
    role = decodedToken['role'];
  }

  factory PersonLogged.fromJsonAdministrator(
      Map<String, dynamic> json, String token) {
    return PersonLogged(pupil: Pupil.fromJson(json), token: token);
  }
  factory PersonLogged.fromJsonTeacher(
      Map<String, dynamic> json, String token) {
    return PersonLogged(teacher: Teacher.fromJson(json), token: token);
  }
  factory PersonLogged.fromJsonPupil(Map<String, dynamic> json, String token) {
    return PersonLogged(
        administrator: Administrator.fromJson(json), token: token);
  }
  bool verifySession() {
    return JwtDecoder.isExpired(token);
  }
}
