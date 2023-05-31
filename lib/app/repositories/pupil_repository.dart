import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:workout_app/app/entities/assessment_entity.dart';
import '../entities/loading_data_entity.dart';
import '../entities/loading_data_pupil.dart';
import '../entities/pupil_entity.dart';
import '../entities/schedule_entity.dart';

class PupilRepository {
  //192.168.20.242 - 172.17.0.1
  var baseUrl = 'http://172.17.0.1:3001/';

  Future<String> savePupil(Map<String, dynamic> dataPupil, String token) async {
    Map<String, String> headers = {'Authorization': 'Bearer $token'};
    final response = await http.post(Uri.parse('${baseUrl}signup/pupil'),
        headers: headers, body: dataPupil);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return "Os dados do aluno foram salvos com sucesso!";
    }
    if (response.statusCode == 401) {
      throw Exception("Acesso não autorizado!");
    }
    if (response.statusCode == 500) {
      throw Exception("Ocorreu uma falha na conexão com o servidor!");
    } else {
      throw Exception('Ocorreu uma falha ao salva os dados do usuário!');
    }
  }

  Future<LoadingData> getDataUser(String token) async {
    Map<String, String> headers = {'Authorization': 'Bearer $token'};
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

    var body = {"id": decodedToken['sub'], "role": decodedToken['role']};
    final response = await http.post(Uri.parse('${baseUrl}loading/data'),
        body: body, headers: headers);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return LoadingData.fromJson(jsonDecode(response.body));
    }
    if (response.statusCode == 401) {
      throw Exception("Acesso não autorizado!");
    }
    if (response.statusCode == 500) {
      throw Exception("Ocorreu uma falha na conexão com o servidor!");
    } else {
      throw Exception("Ocorreu uma falha ao consultar dados do usuário!");
    }
  }

  Future<Pupil> findById(String id, String token) async {
    Map<String, String> headers = {'Authorization': 'Bearer $token'};
    final response = await http.post(Uri.parse('${baseUrl}pupil/find-by-id'),
        headers: headers, body: {"id": id});
    if (response.statusCode == 200 || response.statusCode == 201) {
      return Pupil.fromJson(jsonDecode(response.body));
    }
    if (response.statusCode == 401) {
      throw Exception("Acesso não autorizado!");
    }
    if (response.statusCode == 500) {
      throw Exception("Ocorreu uma falha na conexão com o servidor!");
    } else {
      throw Exception('Ocorreu uma falha ao carregar os dados do aluno!');
    }
  }

  Future<List<Schedule>> getSchedulePupil(String token) async {
    Map<String, String> headers = {'Authorization': 'Bearer $token'};
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    var body = {"id": decodedToken['sub'], "role": decodedToken['role']};
    final response = await http.post(
        Uri.parse('${baseUrl}pupil/fetch-all-schedule-pupil-by-id'),
        headers: headers,
        body: body);
    List<Schedule> schedules = List.empty(growable: true);
    if (response.statusCode == 200 || response.statusCode == 201) {
      List json = jsonDecode(response.body) as List;
      for (var schedule in json) {
        schedules.add(Schedule.fromJson(schedule));
      }
      return schedules;
    }
    if (response.statusCode == 401) {
      throw Exception("Acesso não autorizado!");
    }
    if (response.statusCode == 500) {
      throw Exception("Ocorreu uma falha na conexão com o servidor!");
    } else {
      throw Exception('Ocorreu uma falha ao carregar os dados do aluno!');
    }
  }

  Future<Schedule> findByScheduleId(String scheduleId, String token) async {
    Map<String, String> headers = {'Authorization': 'Bearer $token'};
    final response = await http.post(
        Uri.parse('${baseUrl}pupil/find-by-schedule-id'),
        headers: headers,
        body: {"id": scheduleId});
    if (response.statusCode == 200 || response.statusCode == 201) {
      List listJson = jsonDecode(response.body) as List;
      return Schedule.fromListJson(listJson);
    }
    if (response.statusCode == 401) {
      throw Exception("Acesso não autorizado!");
    }
    if (response.statusCode == 500) {
      throw Exception("Ocorreu uma falha na conexão com o servidor!");
    } else {
      throw Exception('Ocorreu uma falha ao carregar os dados do aluno!');
    }
  }

  Future<List<LoadingDataPupil>> fetchAllPupil(String token) async {
    Map<String, String> headers = {'Authorization': 'Bearer $token'};
    final response = await http.get(Uri.parse('${baseUrl}pupil/fetch-all'),
        headers: headers);
    List<LoadingDataPupil> pupils = List.empty(growable: true);
    if (response.statusCode == 200 || response.statusCode == 201) {
      List json = jsonDecode(response.body) as List;
      for (var pupil in json) {
        pupils.add(LoadingDataPupil.fromJson({'pupil': pupil}));
      }
      return pupils;
    }
    if (response.statusCode == 401) {
      throw Exception("Acesso não autorizado!");
    }
    if (response.statusCode == 500) {
      throw Exception("Ocorreu uma falha na conexão com o servidor!");
    } else {
      throw Exception('Ocorreu uma falha ao carregar dados dos alunos!');
    }
  }

  Future<String> updatePupil(Pupil pupil, String token) async {
    Map<String, String> headers = {'Authorization': 'Bearer $token'};
    final response = await http.post(Uri.parse('${baseUrl}pupil/update'),
        headers: headers, body: pupil.toJson());

    if (response.statusCode == 200 || response.statusCode == 201) {
      return "Os dados do aluno foram salvos com sucesso!";
    }
    if (response.statusCode == 401) {
      throw Exception("Acesso não autorizado!");
    }
    if (response.statusCode == 500) {
      throw Exception("Ocorreu uma falha na conexão com o servidor!");
    } else {
      throw Exception('Ocorreu uma falha ao salva os dados do usuário!');
    }
  }

  Future<String> deletePupil(String id, String token) async {
    Map<String, String> headers = {'Authorization': 'Bearer $token'};
    final response = await http.post(Uri.parse('${baseUrl}pupil/delete'),
        headers: headers, body: {"id": id});
    if (response.statusCode == 200 || response.statusCode == 201) {
      return "Os dados do aluno foram deletados com sucesso!";
    }
    if (response.statusCode == 401) {
      throw Exception("Acesso não autorizado!");
    }
    if (response.statusCode == 500) {
      throw Exception("Ocorreu uma falha na conexão com o servidor!");
    } else {
      throw Exception('Ocorreu uma falha ao carregar os dados do aluno!');
    }
  }

  Future<List<Assessment>> fetchAllAssessmentByPupilId(String token) async {
    Map<String, String> headers = {'Authorization': 'Bearer $token'};
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    String id = decodedToken['sub'];
    final response = await http.post(
        Uri.parse('${baseUrl}pupil/fetch-all-assessment-by-id'),
        headers: headers,
        body: {"id": id});
    List<Assessment> Assessments = List.empty(growable: true);
    if (response.statusCode == 200 || response.statusCode == 201) {
      List json = jsonDecode(response.body) as List;
      for (var assessment in json) {
        Assessments.add(Assessment.fromJson(assessment));
      }
      return Assessments;
    }
    if (response.statusCode == 401) {
      throw Exception("Acesso não autorizado!");
    }
    if (response.statusCode == 500) {
      throw Exception("Ocorreu uma falha na conexão com o servidor!");
    } else {
      throw Exception('Ocorreu uma falha ao carregar dados dos alunos!');
    }
  }

  Future<int> updateTrainingPupil(
      String id, String weight, String token) async {
    Map<String, String> headers = {'Authorization': 'Bearer $token'};
    final response = await http.post(
        Uri.parse('${baseUrl}pupil/update-weight-exercise'),
        headers: headers,
        body: {"id": id, "weight": weight});

    return response.statusCode;
  }
}
