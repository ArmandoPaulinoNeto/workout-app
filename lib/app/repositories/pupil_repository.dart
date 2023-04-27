import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import '../entities/loading_data_entity.dart';
import '../entities/loading_data_pupil.dart';
import '../entities/pupil_entity.dart';

class PupilRepository {
  //192.168.20.242 - 172.17.0.1
  var baseUrl = 'http://172.17.0.1:3000/';

  Future<Pupil> savePupil(Map<String, dynamic> dataPupil, String token) async {
    Map<String, String> headers = {'Authorization': 'Bearer $token'};
    final response = await http.post(Uri.parse('${baseUrl}signup/pupil'),
        headers: headers, body: dataPupil);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Pupil.fromJson(jsonDecode(response.body));
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
    } else {
      throw Exception("Ocorreu uma falha ao consultar dados do usuário!");
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
        pupils.add(LoadingDataPupil.fromJson(pupil));
      }
      return pupils;
    }
    if (response.statusCode == 401) {
      throw Exception("Acesso não autorizado!");
    } else {
      throw Exception('Ocorreu uma falha ao carregar dados dos alunos!');
    }
  }
}
