import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:workout_app/app/entities/teacher_entity.dart';

import '../entities/assessment_entity.dart';
import '../entities/exercise_entity.dart';
import '../entities/loading_data_exercise.dart';
import '../entities/loading_data_teacher.dart';

class AdministratorRepository {
  //192.168.20.242 - 172.17.0.1
  var baseUrl = 'http://172.17.0.1:3001/';

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

  Future<Exercise> seveExercise(
      Map<String, String> dataExercise, String token) async {
    Map<String, String> headers = {'Authorization': 'Bearer $token'};
    final response = await http.post(
        Uri.parse('${baseUrl}administrator/signup/exercise'),
        headers: headers,
        body: dataExercise);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Exercise.fromJson(jsonDecode(response.body));
    }
    if (response.statusCode == 401) {
      throw Exception("Acesso não autorizado!");
    } else {
      throw Exception('Ocorreu uma falha ao salva o exercício!');
    }
  }

  Future<List<LoadingDataTeacher>> fetchAllTeacher(String token) async {
    Map<String, String> headers = {'Authorization': 'Bearer $token'};
    final response = await http.get(
        Uri.parse('${baseUrl}administrator/fetch-all/teacher'),
        headers: headers);
    List<LoadingDataTeacher> teachers = List.empty(growable: true);
    if (response.statusCode == 200 || response.statusCode == 201) {
      List json = jsonDecode(response.body) as List;
      for (var teacher in json) {
        teachers.add(LoadingDataTeacher.fromJson(teacher));
      }
      return teachers;
    }
    if (response.statusCode == 401) {
      throw Exception("Acesso não autorizado!");
    } else {
      throw Exception('Ocorreu uma falha ao carregar dados do professor!');
    }
  }

  Future<List<LoadingDataExercise>> fetchAllExercise(String token) async {
    Map<String, String> headers = {'Authorization': 'Bearer $token'};
    final response = await http.get(
        Uri.parse('${baseUrl}administrator/fetch-all/exercise'),
        headers: headers);
    List<LoadingDataExercise> exercises = List.empty(growable: true);
    if (response.statusCode == 200 || response.statusCode == 201) {
      List json = jsonDecode(response.body) as List;
      for (var exercise in json) {
        exercises.add(LoadingDataExercise.fromJson(exercise));
      }
      return exercises;
    }
    if (response.statusCode == 401) {
      throw Exception("Acesso não autorizado!");
    } else {
      throw Exception('Ocorreu uma falha ao carregar dados do exercício!');
    }
  }

  Future<String> saveAssessment(var dataAssessment, String token) async {
    Map<String, String> headers = {'Authorization': 'Bearer $token'};
    final response = await http.post(
        Uri.parse('${baseUrl}administrator/signup/assessment'),
        headers: headers,
        body: dataAssessment);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    if (response.statusCode == 401) {
      throw Exception("Acesso não autorizado!");
    } else {
      throw Exception('Ocorreu uma falha ao salva os dados do Professor!');
    }
  }
}
