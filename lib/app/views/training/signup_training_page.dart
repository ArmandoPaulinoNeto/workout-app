import 'package:flutter/material.dart';
import 'package:workout_app/app/util/dialog.util.dart';
import 'package:workout_app/app/views/home_person_page.dart';
import '../../component/costum_text_form_field.dart';
import '../../entities/training_entity.dart';
import '../../services/signup_service.dart';
import '../../util/costumPadding.dart';

class SignupTrainingPage extends StatefulWidget {
  String token;
  SignupTrainingPage({super.key, required this.token});

  @override
  State<SignupTrainingPage> createState() => _SignupTrainingPageState();
}

class _SignupTrainingPageState extends State<SignupTrainingPage> {
  CostumPadding costumPadding = CostumPadding();
  Message message = Message();
  final _keyForm = GlobalKey<FormState>();
  late String name;

  _SignupTrainingPageState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Cadastro de Traino'),
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
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    child: Container(
                      width: double.infinity,
                      height: 190,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(
                                  "assets/images/banner_exercise.png"))),
                    ),
                  ),
                  costumPadding.padding(15),
                  CostomTextFormField(
                    label: "name:",
                    iconTextField: Icons.abc_outlined,
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "O campo nome não pode ser vazio.";
                      }
                      if (value.length < 6) {
                        return "Verifique se o nome foi digitado corretamente.";
                      }
                    },
                    onSaved: (value) => {name = value!},
                    readOnly: false,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 100,
                    child: Center(
                      child: Wrap(
                        spacing: 10,
                        children: [
                          Container(
                            child: ElevatedButton.icon(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Color.fromARGB(255, 0, 100, 0)),
                                ),
                                onPressed: () {
                                  _keyForm.currentState!.reset();
                                },
                                label: Text("Cancelar"),
                                icon: Icon(Icons.cancel_outlined)),
                          ),
                          Container(
                            child: ElevatedButton.icon(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Color.fromARGB(255, 0, 100, 0)),
                                ),
                                onPressed: () async {
                                  if (_keyForm.currentState!.validate()) {
                                    _keyForm.currentState!.save();

                                    SignupService signupService =
                                        SignupService();
                                    Training training = await signupService
                                        .createTraining(name, widget.token);
                                    if (training.id != null &&
                                        training.id != "") {
                                      message.dialogBuilder(context, "Alerta",
                                          "Os dados do traino foram salvos corretamente!");
                                    } else {
                                      message.dialogBuilder(context, "Alerta",
                                          "Erro ao salvar os dados do treino!");
                                    }
                                  }
                                },
                                label: Text("Cadastrar"),
                                icon: Icon(Icons.save)),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
