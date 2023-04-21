import 'package:flutter/material.dart';
import 'package:workout_app/app/util/dialog.util.dart';
import 'package:workout_app/app/views/home_person_page.dart';
import '../../component/costum_listview_separated.dart';
import '../../component/costum_text_form_field.dart';
import '../../util/costumPadding.dart';

class FindExercisePage extends StatefulWidget {
  String token;
  FindExercisePage({super.key, required this.token});

  @override
  State<FindExercisePage> createState() => _FindExercisePageState();
}

class _FindExercisePageState extends State<FindExercisePage> {
  CostumPadding costumPadding = CostumPadding();

  Message message = Message();
  var exercises = [
    "Puxada alta ",
    "Remada fixa",
    "Remada baixa",
    "Remada unilateral",
    "Voador invertido",
    "Supino reto barra"
  ];

  String search = "";

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).colorScheme.primary;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text('Buscar Exercício'),
          actions: [
            changeTheme(),
          ],
        ),
        body: SingleChildScrollView(
          child: Form(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 15, 20, 10),
              child: Column(
                children: [
                  CostomTextFormField(
                    label: "pesquisa:",
                    iconTextField: Icons.person_search_rounded,
                    obscureText: false,
                    readOnly: false,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 80,
                    child: Center(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(150, 5, 0, 0),
                            child: ElevatedButton.icon(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Color.fromARGB(255, 0, 100, 0)),
                                ),
                                onPressed: () async {},
                                label: Text("Pesquisar"),
                                icon: Icon(Icons.search)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 160, 15),
                    child: Text("Resultados:",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color.fromARGB(255, 0, 100, 0))),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 240,
                    child: CostumListViewSeparated(
                      itemList: exercises,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
