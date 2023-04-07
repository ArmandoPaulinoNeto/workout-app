import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

import '../entities/access_token_entity.dart';
import '../entities/loading_data_entity.dart';
import '../entities/user_entity.dart';

class UserRepository {
  //192.168.20.242 - 172.17.0.1
  var baseUrl = 'http://172.17.0.1:3000/';

  Future<AccessToken> signinAccessToken(String email, String password) async {
    var body = {"email": email, "password": password};

    final response =
        await http.post(Uri.parse('${baseUrl}signin/access'), body: body);

    if (response.statusCode >= 200 || response.statusCode == 201) {
      return AccessToken.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Ocorreu uma falha ao logar o usuário!');
    }
  }

  Future<User> saveUser(
      String username, String email, String password, String token) async {
    var body = {"username": username, "email": email, "password": password};
    Map<String, String> headers = {'Authorization': 'Bearer $token'};
    final response = await http.post(Uri.parse('${baseUrl}signup'),
        headers: headers, body: body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Ocorreu uma falha ao salva os dados do usuário!');
    }
  }

  Future<LoadingData> getDataUser(String token) async {
    Map<String, String> headers = {'Authorization': 'Bearer $token'};
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

    var body = {"id": decodedToken['sub'], "role": decodedToken['role']};
    print(body);
    final response = await http.post(Uri.parse('${baseUrl}loading/data'),
        body: body, headers: headers);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return LoadingData.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Ocorreu uma falha ao consultar dados do usuário!');
    }
  }
}
