import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:workout_app/app/entities/teacher_entity.dart';

class TeacherRepository {
  //192.168.20.242 - 172.17.0.1
  var baseUrl = 'http://172.17.0.1:3000/';

  Future<Teacher> saveTeacher(
      Map<String, dynamic> dataTeacher, String token) async {
    Map<String, String> headers = {'Authorization': 'Bearer $token'};
    final response = await http.post(
        Uri.parse('${baseUrl}administrator/signup/teacher'),
        headers: headers,
        body: dataTeacher);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Teacher.fromJson(jsonDecode(response.body));
    }
    if (response.statusCode == 401) {
      throw Exception("Acesso não autorizado!");
    } else {
      throw Exception('Ocorreu uma falha ao salva os dados do Professor!');
    }
  }
}
