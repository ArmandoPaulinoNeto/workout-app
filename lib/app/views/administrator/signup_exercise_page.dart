import 'package:flutter/material.dart';
import 'package:workout_app/app/util/dialog.util.dart';
import 'package:workout_app/app/views/home_person_page.dart';
import '../../component/costum_text_form_field.dart';
import '../../util/costumPadding.dart';

class SignupExercisePage extends StatefulWidget {
  const SignupExercisePage({super.key});

  @override
  State<SignupExercisePage> createState() => _SignupExercisePageState();
}

class _SignupExercisePageState extends State<SignupExercisePage> {
  CostumPadding costumPadding = CostumPadding();
  Message message = Message();
  final _keyForm = GlobalKey<FormState>();
  late String name;
  final List<String> muscleGroupList = <String>[
    "Peito",
    "Costas",
    "Biceps",
    "Triceps",
    "Perna"
  ];
  String? _selectedvalue = "";

  _SignupExercisePageState() {
    _selectedvalue = muscleGroupList[0];
  }

  String nameExercise = "";
  String muscleGroup = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Cad. exercício'),
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
                        return "O campo nome não pode ser vazio.";
                      }
                      if (value.length < 6) {
                        return "Verifique se o nome foi digitado corretamente.";
                      }
                    },
                    onSaved: (value) => {name = value!},
                    readOnly: false,
                  ),
                  costumPadding.padding(15),
                  DropdownButtonFormField(
                    value: _selectedvalue,
                    items: muscleGroupList
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
                      labelText: "Grupo Muscular:",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      prefixIcon: Icon(Icons.assignment),
                    ),
                    onSaved: (value) {
                      muscleGroup = value!;
                    },
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 450,
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
                                onPressed: () async {},
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
