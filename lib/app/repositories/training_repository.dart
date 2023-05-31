import 'dart:convert';

import 'package:http/http.dart' as http;
import '../entities/training_entity.dart';

class TrainingRepository {
  //192.168.20.242 - 172.17.0.1
  var baseUrl = 'http://172.17.0.1:3001/';

  Future<Training> saveTraining(
      Map<String, dynamic> dataTraining, String token) async {
    Map<String, String> headers = {'Authorization': 'Bearer $token'};
    final response = await http.post(Uri.parse('${baseUrl}signup/training'),
        headers: headers, body: jsonEncode(dataTraining));

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Training.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Ocorreu uma falha ao salva os dados do treino!');
    }
  }

  Future<List<Training>> fetchAllTraining(String token) async {
    Map<String, String> headers = {'Authorization': 'Bearer $token'};
    final response = await http.get(Uri.parse('${baseUrl}training/fetch-all'),
        headers: headers);

    if (response.statusCode == 200 || response.statusCode == 201) {
      List<Training> listTraining = List.empty(growable: true);
      List json = jsonDecode(response.body) as List;
      for (var training in json) {
        listTraining.add(Training.fromJson(training));
      }
      return listTraining;
    } else {
      throw Exception('Ocorreu uma falha ao carregar os dados do treino!');
    }
  }
}
