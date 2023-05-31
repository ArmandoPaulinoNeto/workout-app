import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:workout_app/app/entities/access_token_entity.dart';
import 'package:workout_app/app/util/dialog.util.dart';
import 'package:workout_app/app/views/home_person_page.dart';
import 'package:workout_app/app/views/pupil/pageview_pupil_page.dart';
import '../component/costum_text_form_field.dart';
import 'package:string_validator/string_validator.dart' as string_validator;
import '../controlles/app_controller.dart';
import '../entities/person_logged.dart';
import '../services/pupil_service.dart';
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
                      if (!string_validator.isEmail(value)) {
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
                                  AccessToken accessToken = await signinService
                                      .signinPerson(email, password);
                                  if (accessToken.token != null ||
                                      accessToken.token.length > 100) {
                                    PersonLogged personLogged =
                                        PersonLogged(token: accessToken.token);
                                    if (personLogged.role!
                                        .contains("administrator")) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => HomePersonPage(
                                                  token: accessToken.token)));
                                    }
                                    if (personLogged.role!
                                        .contains("teacher")) {}
                                    if (personLogged.role!.contains("pupil")) {
                                      print(
                                          "${personLogged.personId!}\n${personLogged.token}");
                                      PupilService pupilService =
                                          PupilService();
                                      personLogged.pupil =
                                          await pupilService.findById(
                                              personLogged.personId!,
                                              personLogged.token);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => PageviewPupil(
                                                  pupilLogged: personLogged)));
                                    }
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
