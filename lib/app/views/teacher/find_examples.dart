import 'package:flutter/material.dart';
import 'package:workout_app/app/util/dialog.util.dart';
import 'package:workout_app/app/views/home_person_page.dart';
import 'package:string_validator/string_validator.dart' as stringValidator;
import '../../component/costum_text_form_field.dart';
import '../../util/costumPadding.dart';

class FindExamples extends StatefulWidget {
  const FindExamples({super.key});

  @override
  State<FindExamples> createState() => _FindExamplesState();
}

class _FindExamplesState extends State<FindExamples> {
  final _keyForm = GlobalKey<FormState>();
  late String name;
  late String birthday;
  late String gender;
  late String email;
  late String password;

  CostumPadding costumPadding = CostumPadding();

  Message message = Message();

  String nameExercise = "";
  String muscleGroup = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Buscar exercícios'),
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
                        return "O campo nome não pode ser vazio.";
                      }
                      if (value.length < 6) {
                        return "Verifique se o nome foi digitado corretamente.";
                      }
                    },
                    onSaved: (value) => {name = value!},
                  ),
                  costumPadding.padding(15),
                  CostomTextFormField(
                    label: "Data de Nascimento:",
                    iconTextField: Icons.date_range,
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "O campo data não pode ser vazio.";
                      }
                      if (!stringValidator.isDate(value)) {
                        return "Verifique se a data foi digitada corretamente.";
                      }
                    },
                    onSaved: (value) => {birthday = value!},
                  ),
                  costumPadding.padding(15),
                  CostomTextFormField(
                    label: "Sexo:",
                    iconTextField: Icons.type_specimen,
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "O campo sexo não pode ser vazio.";
                      }
                    },
                    onSaved: (value) => {gender = value!},
                  ),
                  costumPadding.padding(15),
                  CostomTextFormField(
                    label: "Email:",
                    iconTextField: Icons.mail,
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "O campo email não pode ser vazio.";
                      }
                      if (!stringValidator.isEmail(value)) {
                        return "Verifique se email foi digitado corretamente.";
                      }
                    },
                    onSaved: (value) => {email = value!},
                  ),
                  costumPadding.padding(15),
                  CostomTextFormField(
                    label: "Senha:",
                    iconTextField: Icons.lock,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "O campo senha não pode ser vazio.";
                      }
                      if (value.length < 6) {
                        return "Escolha um senha com no minimo 6 dígitos.";
                      }
                    },
                    onSaved: (value) => {password = value!},
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
                                          \tSexo: ${gender}\n
                                          \tEmail: ${email}\n
                                          \tSenha: ${password}""");
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
