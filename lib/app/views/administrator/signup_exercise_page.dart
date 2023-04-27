import 'package:flutter/material.dart';
import 'package:workout_app/app/services/signup_administrator_service.dart';
import 'package:workout_app/app/util/dialog.util.dart';
import 'package:workout_app/app/views/home_person_page.dart';
import '../../component/costum_text_form_field.dart';
import '../../entities/exercise_entity.dart';
import '../../util/costumPadding.dart';

class SignupExercisePage extends StatefulWidget {
  String token;
  SignupExercisePage({super.key, required this.token});

  @override
  State<SignupExercisePage> createState() => _SignupExercisePageState();
}

class _SignupExercisePageState extends State<SignupExercisePage> {
  CostumPadding costumPadding = CostumPadding();
  Message message = Message();
  final _keyForm = GlobalKey<FormState>();
  final List<String> muscleGroupList = <String>[
    "Peito",
    "Costas",
    "Biceps",
    "Triceps",
    "Perna"
  ];
  String? _selectedvalue = "";
  late String name;
  late String muscleGroup;

  _SignupExercisePageState() {
    _selectedvalue = muscleGroupList[0];
  }

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
                                    SignupAdministratorService
                                        administratorService =
                                        SignupAdministratorService();

                                    Exercise exercise =
                                        await administratorService
                                            .createExecise(name, muscleGroup,
                                                widget.token);
                                    if (exercise.id != null) {
                                      message.dialogBuilder(context, "Alerta",
                                          """Exercício salvo com sucesso!""");
                                    } else {
                                      message.dialogBuilder(context, "Alerta",
                                          """Erro ao tenta salvar o execício!""");
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
