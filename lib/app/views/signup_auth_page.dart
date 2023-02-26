import 'package:flutter/material.dart';
import 'package:workout_app/app/services/signup_service.dart';
import 'package:workout_app/app/views/signup_page.dart';
import '../controlles/app_controller.dart';
import '../entities/access_token_entity.dart';
import '../util/costumPadding.dart';

class SignupAuthPage extends StatefulWidget {
  const SignupAuthPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return SignupAuthPageState();
  }
}

class SignupAuthPageState extends State<SignupAuthPage> {
  CostumPadding costumPadding = CostumPadding();
  SignupService auth = SignupService();
  String cpf = "";
  String plate = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Auth'),
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
                    costumPadding.padding(10),
                    TextField(
                      onChanged: (text) {
                        plate = text;
                      },
                      decoration: InputDecoration(
                        labelText: "Matrícula",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    costumPadding.padding(5),
                    TextField(
                      onChanged: (text) {
                        cpf = text;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: "CPF", border: OutlineInputBorder()),
                    ),
                    costumPadding.padding(10),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () async {
                            AccessToken accessToken =
                                await auth.findUserByPlateCpf(plate, cpf);

                            if (accessToken.token.length > 25) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => SignupPage(
                                            token: accessToken.token,
                                          )));
                            } else {
                              _dialogBuilder(
                                  context, "Alerta!", "Aluno não encontrado!");
                            }
                          },
                          child: const Text("Acessar")),
                    ),
                  ]),
            ),
          ),
        ));
  }
}

class changeTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Switch(
      value: AppController.instance.isDarkTheme,
      onChanged: (value) {
        AppController.instance.changeTheme();
      },
    );
  }
}

Future<void> _dialogBuilder(BuildContext context, String title, String msg) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(msg),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Fechar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
