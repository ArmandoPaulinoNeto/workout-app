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
  CostumPadding costumPadding = CostumPadding();

  Message message = Message();

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
                    iconTextField: Icons.person,
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
                  ),
                  costumPadding.padding(15),
                  CostomTextFormField(
                    label: "Exercício:",
                    iconTextField: Icons.task_alt,
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "O campo execicio não pode ser vazio.";
                      }
                      if (value.length < 6) {
                        return "Verifique se o execicio foi digitado corretamente.";
                      }
                    },
                    onSaved: (value) => {exercise = value!},
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 100,
                    child: Center(
                      child: Wrap(
                        spacing: 10,
                        children: [
                          Container(
                            width: 130,
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
                                onPressed: () {
                                  _keyForm.currentState!.reset();
                                },
                                label: Text("Cancelar"),
                                icon: Icon(Icons.cancel_outlined)),
                          ),
                          Container(
                            child: ElevatedButton.icon(
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

listVeiwBuilder(var itemList) {
  return ListView.separated(
    itemBuilder: (BuildContext context, int index) {
      return ListTile(
        trailing: Container(
          width: 48,
          height: 48,
          child: Image(image: AssetImage("assets/images/edit_file_icon.png")),
        ),
        title: Text(itemList[index]),
        subtitle: Text("Ultimo traino: " + index.toString()),
      );
    },
    separatorBuilder: (_, __) => Divider(),
    itemCount: itemList.length,
  );
}
