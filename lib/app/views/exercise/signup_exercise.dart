import 'package:flutter/material.dart';
import 'package:workout_app/app/util/dialog.util.dart';
import 'package:workout_app/app/views/home_person_page.dart';
import '../../component/costum_text_form_field.dart';
import '../../util/costumPadding.dart';

class SignupExercise extends StatefulWidget {
  const SignupExercise({super.key});

  @override
  State<SignupExercise> createState() => _SignupExerciseState();
}

class _SignupExerciseState extends State<SignupExercise> {
  final _keyForm = GlobalKey<FormState>();
  String nameExercise = "";
  String muscleGroup = "";
  CostumPadding costumPadding = CostumPadding();

  Message message = Message();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Cadastrar Exercício'),
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
                        return "O campo nome do exrcício não pode ser vazio.";
                      }
                      if (value.length < 6) {
                        return "Verifique se o nome do exrcício foi digitado corretamente.";
                      }
                    },
                    onSaved: (value) => {nameExercise = value!},
                  ),
                  costumPadding.padding(15),
                  CostomTextFormField(
                    label: "Grupo Muscular:",
                    iconTextField: Icons.date_range,
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "O campo Grupo Muscular não pode ser vazio.";
                      }
                      if (value.length < 6) {
                        return "Verifique se o Grupo Muscular foi digitado corretamente.";
                      }
                    },
                    onSaved: (value) => {muscleGroup = value!},
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
                                          \tNome: ${nameExercise}\n
                                          \tSexo: ${muscleGroup}""");
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
