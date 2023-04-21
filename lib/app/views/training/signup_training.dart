import 'package:flutter/material.dart';
import 'package:workout_app/app/util/dialog.util.dart';
import 'package:workout_app/app/views/home_person_page.dart';
import '../../component/costum_text_form_field.dart';
import '../../util/costumPadding.dart';

class SignupTraining extends StatefulWidget {
  const SignupTraining({super.key});

  @override
  State<SignupTraining> createState() => _SignupTrainingState();
}

class _SignupTrainingState extends State<SignupTraining> {
  final _keyForm = GlobalKey<FormState>();
  String name = "";
  String exercise = "";
  String repetition = "";
  String series = "";
  String observatios = "";

  final List<String> exercisesList = <String>[
    "Puxada alta ",
    "Remada fixa",
    "Remada baixa",
    "Remada unilateral",
    "Voador invertido",
    "Supino reto barra"
  ];
  String? _selectedvalue = "";

  CostumPadding costumPadding = CostumPadding();
  Message message = Message();

  _SignupTrainingState() {
    _selectedvalue = exercisesList[0];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Cadastrar Traino'),
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
                  CostomTextFormField(
                    label: "name:",
                    iconTextField: Icons.abc_outlined,
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "O campo nome do treino não pode ser vazio.";
                      }
                      if (value.length < 6) {
                        return "Verifique se o nome do treino foi digitado corretamente.";
                      }
                    },
                    onSaved: (value) => {name = value!},
                    readOnly: false,
                  ),
                  costumPadding.padding(15),
                  DropdownButtonFormField(
                    value: _selectedvalue,
                    items: exercisesList
                        .map((e) => DropdownMenuItem(
                              child: Text(e),
                              value: e,
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedvalue = value as String;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "Exercícios:",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      prefixIcon: Icon(Icons.assignment),
                    ),
                    onSaved: (value) {
                      exercise = value!;
                    },
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 100,
                    child: Center(
                      child: Wrap(
                        spacing: 10,
                        children: [
                          Container(
                            width: 140,
                            child: CostomTextFormField(
                              label: "Repetições:",
                              iconTextField: Icons.task_alt,
                              obscureText: false,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "O campo repetições não pode ser vazio.";
                                }
                                if (value.length < 6) {
                                  return "Verifique se o repetições foi digitado corretamente.";
                                }
                              },
                              onSaved: (value) => {repetition = value!},
                              readOnly: false,
                            ),
                          ),
                          Container(
                            width: 130,
                            child: CostomTextFormField(
                              label: "Séries:",
                              iconTextField: Icons.task_alt,
                              obscureText: false,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "O campo séries não pode ser vazio.";
                                }
                                if (value.length < 6) {
                                  return "Verifique se o séries foi digitado corretamente.";
                                }
                              },
                              onSaved: (value) => {exercise = value!},
                              readOnly: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  CostomTextFormField(
                    label: "Observações:",
                    iconTextField: Icons.perm_contact_calendar_outlined,
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "O campo Observações não pode ser vazio.";
                      }
                      if (value.length < 6) {
                        return "Verifique se o Observações foi digitado corretamente.";
                      }
                    },
                    onSaved: (value) => {observatios = value!},
                    readOnly: false,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 200,
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
                                onPressed: () {
                                  if (_keyForm.currentState!.validate()) {
                                    _keyForm.currentState!.save();
                                    message.dialogBuilder(
                                        context, "Save:", """Save:
                                          \tNome: ${name}\n
                                          \tExercise: ${exercise}""");
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
