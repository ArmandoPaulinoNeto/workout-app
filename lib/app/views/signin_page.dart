import 'package:flutter/material.dart';
import 'package:workout_app/app/entities/access_token_entity.dart';
import 'package:workout_app/app/util/dialog.util.dart';
import 'package:workout_app/app/views/home_person_page.dart';
import '../component/costum_text_form_field.dart';
import 'package:string_validator/string_validator.dart' as stringValidator;
import '../entities/loading_data_entity.dart';
import '../services/signin_service.dart';
import '../util/costumPadding.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final _keyForm = GlobalKey<FormState>();
  SigninService signinService = SigninService();

  late String email;
  late String password;

  CostumPadding costumPadding = CostumPadding();

  Message message = Message();

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
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _keyForm,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(
                                "assets/images/logo_mais_forma.png"))),
                  ),
                  costumPadding.padding(15),
                  CostomTextFormField(
                    label: "Email:",
                    iconTextField: Icons.mail,
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "O campo email está vazio.";
                      }
                      if (!stringValidator.isEmail(value)) {
                        return "Verifique se email foi digitado corretamente.";
                      }
                    },
                    onSaved: (value) => {email = value!},
                    readOnly: false,
                  ),
                  costumPadding.padding(15),
                  CostomTextFormField(
                    label: "Senha:",
                    iconTextField: Icons.lock,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "O campo senha está vazio.";
                      }
                    },
                    onSaved: (value) => {password = value!},
                    readOnly: false,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 100,
                    child: Wrap(
                      spacing: 10,
                      children: [
                        Center(
                          child: TextButton(
                            onPressed: () {
                              //forgot password screen
                            },
                            child: const Text(
                              'Esqueceu sua senha?',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Color.fromARGB(255, 47, 79, 79),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color.fromARGB(255, 0, 100, 0)),
                              ),
                              onPressed: () async {
                                if (_keyForm.currentState!.validate()) {
                                  _keyForm.currentState!.save();
                                  var response = await signinService
                                      .signinPerson(email, password);
                                  AccessToken accessToken = response;
                                  if (accessToken.token.length > 100) {
                                    LoadingData loadingData =
                                        await signinService
                                            .getDataHome(accessToken.token);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => HomePersonPage(
                                                  token: accessToken.token,
                                                  loadingData: loadingData,
                                                )));
                                    _keyForm.currentState!.reset();
                                  } else {
                                    message.dialogBuilder(context, "Alerta",
                                        "Email ou Senha inválida!");
                                  }
                                }
                              },
                              label: Text("Entrar"),
                              icon: Icon(Icons.login_outlined)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
