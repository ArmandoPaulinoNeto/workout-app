import 'dart:convert';

import 'package:http/http.dart' as http;
import '../entities/schedule_entity.dart';
import '../entities/training_entity.dart';

class ScheduleRepository {
  //192.168.20.242 - 172.17.0.1
  var baseUrl = 'http://172.17.0.1:3001/';

  Future<String> saveSchedule(
      Map<String, dynamic> dataSchedule, String token) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var body = jsonEncode(dataSchedule);
    final encoding = Encoding.getByName('utf-8');
    final response = await http.post(Uri.parse('${baseUrl}signup/schedule'),
        headers: headers, body: body, encoding: encoding);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    if (response.statusCode == 401) {
      throw Exception("Acesso não autorizado!");
    }
    if (response.statusCode == 500) {
      throw Exception("Ocorreu uma falha na conexão com o servidor!");
    } else {
      throw Exception('Ocorreu uma falha ao salva os dados do agendamento!');
    }
  }

  Future<List<Schedule>> fetchAllTraining(String token) async {
    Map<String, String> headers = {'Authorization': 'Bearer $token'};
    final response = await http.get(Uri.parse('${baseUrl}training/fetch-all'),
        headers: headers);

    if (response.statusCode == 200 || response.statusCode == 201) {
      List<Schedule> listShedule = List.empty(growable: true);
      List json = jsonDecode(response.body) as List;
      for (var schedule in json) {
        listShedule.add(Schedule.fromJson(schedule));
      }
      return listShedule;
    } else {
      throw Exception('Ocorreu uma falha ao carregar os dados do agendamento!');
    }
  }
}
