import 'package:flutter/material.dart';
import 'package:workout_app/app/entities/access_token_entity.dart';
import 'package:workout_app/app/repositories/user_repository.dart';
import 'package:workout_app/app/util/dialog.util.dart';
import '../entities/signup_user_entity.dart';
import '../services/signin_service.dart';
import '../util/costumPadding.dart';
import 'home_page.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  CostumPadding costumPadding = new CostumPadding();
  Messege messege = Messege();
  SigninService signinService = SigninService();
  String password = "";
  String emailOrUsername = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Signin'),
          actions: [
            changeTheme(),
          ],
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image:
                                  AssetImage("assets/images/logo-forma.png"))),
                    ),
                    costumPadding.padding(20),
                    TextField(
                      onChanged: (text) {
                        emailOrUsername = text;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email ou Usuário",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    costumPadding.padding(10),
                    TextField(
                      onChanged: (text) {
                        password = text;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: "Senha", border: OutlineInputBorder()),
                    ),
                    costumPadding.padding(5),
                    TextButton(
                      onPressed: () {
                        //forgot password screen
                      },
                      child: const Text(
                        'Esqueceu sua Senha?',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                    costumPadding.padding(5),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () async {
                            AccessToken accessToken = await signinService
                                .signinUser(emailOrUsername, password);
                            if (accessToken.token.isNotEmpty) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          HomePage(token: accessToken.token)));
                            } else {
                              messege.dialogBuilder(
                                  context, "Alerta", "Aluno não encontrado!");
                            }
                          },
                          child: Text("Acessar")),
                    ),
                    costumPadding.padding(5),
                    Row(
                      children: <Widget>[
                        const Text('Não possui conta, ainda?'),
                        TextButton(
                          child: const Text(
                            'Cadastrar',
                            style: TextStyle(fontSize: 10),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed("/signup-auth");
                          },
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ]),
            ),
          ),
        ));
  }
}
