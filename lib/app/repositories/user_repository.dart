import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:workout_app/app/entities/signup_user_entity.dart';

import '../entities/access_token_entity.dart';
import '../entities/user_entity.dart';

class UserRepository {
  Future<AccessToken> firstAccess(String plate, String cpf) async {
    var body = {"plate": plate, "cpf": cpf};

    final response = await http
        .post(Uri.parse('http://localhost:3000/firstaccess'), body: body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return AccessToken.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Ocorreu uma falha ao autenticar o usuário!');
    }
  }

  Future<AccessToken> signinAccessToken(
      String emailOrUsername, String password) async {
    var body = {"emailOrUsername": emailOrUsername, "password": password};

    final response =
        await http.post(Uri.parse('http://localhost:3000/user'), body: body);

    if (response.statusCode >= 200 || response.statusCode == 201) {
      return AccessToken.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Ocorreu uma falha ao logar o usuário!');
    }
  }

  Future<SignupUser> signinUser(String emailOrUsername, String password) async {
    var body = {"emailOrUsername": emailOrUsername, "password": password};

    final response =
        await http.post(Uri.parse('http://localhost:3000/user'), body: body);

    if (response.statusCode >= 200 || response.statusCode == 201) {
      return SignupUser.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Ocorreu uma falha ao logar o usuário!');
    }
  }

  Future<User> saveUser(
      String username, String email, String password, String token) async {
    var body = {"username": username, "email": email, "password": password};
    Map<String, String> headers = {'Authorization': 'Bearer $token'};
    final response = await http.post(Uri.parse('http://localhost:3000/signup'),
        headers: headers, body: body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Ocorreu uma falha ao salva os dados do usuário!');
    }
  }
}
