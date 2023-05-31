import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

import '../entities/access_token_entity.dart';
import '../entities/loading_data_entity.dart';
import '../entities/loading_data_pupil.dart';

class SigninRepository {
  //192.168.20.242 - 172.17.0.1
  var baseUrl = 'http://172.17.0.1:3001/';

  Future<AccessToken> signinAccessToken(String email, String password) async {
    var body = {"email": email, "password": password};

    final response =
        await http.post(Uri.parse('${baseUrl}signin/access'), body: body);

    if (response.statusCode >= 200 || response.statusCode == 201) {
      return AccessToken.fromJson(jsonDecode(response.body));
    }
    if (response.statusCode == 401) {
      throw Exception("Acesso não autorizado!");
    }
    if (response.statusCode == 500) {
      throw Exception("Ocorreu uma falha na conexão com o servidor!");
    } else {
      throw Exception('Ocorreu uma falha ao logar o usuário!');
    }
  }

  Future<LoadingData> getDataAdministrator(String token) async {
    Map<String, String> headers = {'Authorization': 'Bearer $token'};
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

    var body = {"id": decodedToken['sub'], "role": decodedToken['role']};
    final response = await http.post(
        Uri.parse('${baseUrl}loading-data/administrator'),
        body: body,
        headers: headers);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return LoadingData.fromJson(jsonDecode(response.body));
    }
    if (response.statusCode == 401) {
      throw Exception("Acesso não autorizado!");
    }
    if (response.statusCode == 500) {
      throw Exception("Ocorreu uma falha na conexão com o servidor!");
    } else {
      throw Exception('Ocorreu uma falha ao consultar os dados do usuário!');
    }
  }

  Future<LoadingDataPupil> getDataHomePupil(String token) async {
    Map<String, String> headers = {'Authorization': 'Bearer $token'};
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

    var body = {"id": decodedToken['sub'], "role": decodedToken['role']};
    final response = await http.post(Uri.parse('${baseUrl}loading-data/pupil'),
        body: body, headers: headers);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return LoadingDataPupil.fromJson(jsonDecode(response.body));
    }
    if (response.statusCode == 401) {
      throw Exception("Acesso não autorizado!");
    }
    if (response.statusCode == 500) {
      throw Exception("Ocorreu uma falha na conexão com o servidor!");
    } else {
      throw Exception('Ocorreu uma falha ao consultar os dados do aluno!');
    }
  }
}
