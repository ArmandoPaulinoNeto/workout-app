import 'package:flutter/material.dart';
import 'package:workout_app/app/repositories/user_repository.dart';
import '../controlles/app_controller.dart';
import '../entities/user_entity.dart';
import '../util/costumPadding.dart';
import '../util/dialog.util.dart';
import 'home_page.dart';

class SignupPage extends StatefulWidget {
  String token;
  SignupPage({Key? key, required this.token}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SignupPageState();
  }
}

class SignupPageState extends State<SignupPage> {
  CostumPadding costumPadding = CostumPadding();
  UserRepository userRepository = UserRepository();
  String username = "";
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Signup'),
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
                    TextField(
                      onChanged: (text) {
                        username = text;
                      },
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          labelText: "Usuário", border: OutlineInputBorder()),
                    ),
                    costumPadding.padding(10),
                    TextField(
                      onChanged: (text) {
                        email = text;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
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
                    costumPadding.padding(10),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () async {
                            User user = await userRepository.saveUser(
                                username, email, password, widget.token);
                            Messege messege = Messege();

                            if (user.id != "") {
                              messege.dialogBuilder(context, "Mensagem",
                                  "O usuário foi salvo com sucesso!");

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          HomePage(token: widget.token)));
                            } else {
                              messege.dialogBuilder(context, "Mensagem",
                                  "Falha ao salva o usuário!");
                            }
                          },
                          child: Text("Enviar")),
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
