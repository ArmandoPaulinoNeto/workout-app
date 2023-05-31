import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:workout_app/app/util/dialog.util.dart';
import 'package:workout_app/app/views/home_person_page.dart';
import '../../component/costum_text_form_field.dart';
import '../../entities/list_separated_item.dart';
import '../../entities/loading_data_exercise.dart';
import '../../entities/loading_data_pupil.dart';
import '../../entities/training_entity.dart';
import '../../services/administrator_service.dart';
import '../../util/alert_signup_pupil.dart';
import '../../util/costumPadding.dart';
import '../pupil/signup_pupil_page.dart';
import 'signup_schedule_two_page.dart';

class SignupScheduleOnePage extends StatefulWidget {
  String token;
  Future<List<Training>> listTrainingItem;
  Future<List<LoadingDataPupil>> listPupilItem;

  SignupScheduleOnePage(
      {super.key,
      required this.token,
      required this.listTrainingItem,
      required this.listPupilItem});

  @override
  State<SignupScheduleOnePage> createState() => _SignupScheduleOnePageState();
}

class _SignupScheduleOnePageState extends State<SignupScheduleOnePage> {
  final _keyForm = GlobalKey<FormState>();
  var trainingList = ["SELECIONAR"];
  final List<String> trainingDayList = <String>[
    "SELECIONAR",
    "Segunda-feira",
    "Terça-feira",
    "Quarta-feira",
    "Quinta-feira",
    "Sexta-feira",
    "Sábado",
    "Domingo"
  ];

  String inputName = "";
  String inputDay = "";
  String? _selectedvalue = "";
  String? _selectedvalue1 = "";

  CostumPadding costumPadding = CostumPadding();
  Message inputMessage = Message();
  late String message;
  late String role;
  List<Training> fullListItemTraining = List.empty(growable: true);
  List<ListSeparatedItem> fullListItemPupil = List.empty(growable: true);
  late List<ListSeparatedItem> _multablelistItemPupil =
      List.empty(growable: true);
  late String name;
  late String id;
  late Map<String, String> pupilSelected = {"id": "", "name": ""};
  late Training trainingSelected;

  @override
  initState() {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(widget.token);
    id = decodedToken['sub'];
    role = decodedToken['role'];
    widget.listTrainingItem.then((listTraining) => {
          listTraining.forEach((it) {
            trainingList.add(it.name);
          })
        });
    widget.listPupilItem.then((listPupil) => {
          if (listPupil.isNotEmpty)
            {
              listPupil.forEach((it) {
                fullListItemPupil.add(ListSeparatedItem.fromJson(
                    it.pupil?.id, it.pupil?.name, null, null, null));
              }),
              _multablelistItemPupil = fullListItemPupil
            }
          else
            {
              message =
                  "Nenhum registro encontrado\n\nPara realizar um agendamento é preciso ao menos um aluno cadastrado!",
              AlertDialogMessage()
                  .AlertSignupPupil(context, message, null, widget.token)
            }
        });
    super.initState();
  }

  _SignupScheduleOnePageState() {
    _selectedvalue = trainingDayList[0];
    _selectedvalue1 = trainingList[0];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Agendar Traino'),
          actions: [
            changeTheme(),
          ],
        ),
        body: SingleChildScrollView(
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _keyForm,
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Column(
                children: [
                  FutureBuilder<List<LoadingDataPupil>>(
                      future: widget.listPupilItem,
                      builder: (context,
                          AsyncSnapshot<List<LoadingDataPupil>> snapshot) {
                        if (snapshot.hasData) {
                          return showListOrSelectedPupil(
                              pupilSelected['name']!);
                        } else {
                          return CircularProgressIndicator();
                        }
                      }),
                  FutureBuilder<List<Training>>(
                      future: widget.listTrainingItem,
                      builder:
                          (context, AsyncSnapshot<List<Training>> snapshot) {
                        if (snapshot.hasData) {
                          fullListItemTraining = snapshot.data!;
                          return SizedBox(
                            width: double.infinity,
                            child: trainingList.isNotEmpty
                                ? Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    child: DropdownButtonFormField(
                                      value: _selectedvalue1,
                                      items: trainingList
                                          .map((e) => DropdownMenuItem(
                                                child: Text(e),
                                                value: e,
                                              ))
                                          .toList(),
                                      decoration: InputDecoration(
                                        labelText: "Trainos:",
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8))),
                                        prefixIcon: Icon(Icons.assignment),
                                      ),
                                      onChanged: (value) async {
                                        if (!value!.contains("SELECIONAR")) {
                                          inputName = value;
                                          _selectedvalue1 = inputName;
                                        }
                                      },
                                      validator: (value) {
                                        if (value!.contains("SELECIONAR")) {
                                          return "O nome do traino ainda não foi selecionado.";
                                        }
                                      },
                                      onSaved: (value) {
                                        for (var it in fullListItemTraining) {
                                          if (it.name.contains(value!)) {
                                            trainingSelected = it;
                                          }
                                        }
                                      },
                                    ),
                                  )
                                : Container(
                                    alignment: Alignment.topCenter,
                                    child: Text("Nenhum resultado encontrado!",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Color.fromARGB(
                                                255, 47, 79, 79))),
                                  ),
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      }),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: DropdownButtonFormField(
                      value: _selectedvalue,
                      items: trainingDayList
                          .map((e) => DropdownMenuItem(
                                child: Text(e),
                                value: e,
                              ))
                          .toList(),
                      onChanged: (value) async {
                        if (!value!.contains("SELECIONAR")) {
                          inputDay = value;
                          _selectedvalue = inputDay;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: "Dia do Treino:",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        prefixIcon: Icon(Icons.assignment),
                      ),
                      onSaved: (value) {
                        inputDay = value!;
                      },
                      validator: (value) {
                        if (value!.contains("SELECIONAR")) {
                          return "O dia do traino ainda não foi selecionado.";
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
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
                                  _selectedvalue = trainingDayList[0];
                                  _selectedvalue1 = trainingList[0];
                                  _multablelistItemPupil = fullListItemPupil;
                                  setState(() {
                                    pupilSelected = {"id": "", "name": ""};
                                  });
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
                                    if (pupilSelected['name']!.isNotEmpty) {
                                      _keyForm.currentState!.save();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  SignupScheduleTwoPage(
                                                      token: widget.token,
                                                      pupil: pupilSelected,
                                                      training:
                                                          trainingSelected,
                                                      trainingDay: inputDay,
                                                      listSeparetedItemExecise:
                                                          fetchAllExercise(
                                                              widget.token))));
                                    } else {
                                      inputMessage.dialogBuilder(
                                          context,
                                          "Alerta",
                                          "Para realizar o agendamento de um traino é preciso que um aluno seja selecionado.");
                                    }
                                  }
                                },
                                label: Text("Continuar"),
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

  Widget showListOrSelectedPupil(String pupil) {
    return pupil.isEmpty
        ? SingleChildScrollView(
            child: Column(children: [
              CostomTextFormField(
                label: "pesquisa:",
                iconTextField: Icons.search_rounded,
                obscureText: false,
                readOnly: false,
                onChanged: (value) => _runPupilFilter(value),
              ),
              SizedBox(
                width: double.infinity,
                height: 180,
                child: _multablelistItemPupil.isNotEmpty
                    ? ListView.separated(
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            trailing: ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: Container(
                                  width: 36,
                                  height: 36,
                                  color: Color.fromARGB(255, 0, 100, 0),
                                  child: Center(
                                    child: IconButton(
                                      icon: Icon(Icons.check_box_outline_blank,
                                          color: Colors.white),
                                      onPressed: () async {
                                        setState(() {
                                          pupilSelected['name'] =
                                              fullListItemPupil[index].title;
                                          pupilSelected['id'] =
                                              fullListItemPupil[index].id;
                                        });
                                      },
                                    ),
                                  )),
                            ),
                            title: Text(
                              _multablelistItemPupil[index].title,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 0, 100, 0)),
                            ),
                            subtitle: _multablelistItemPupil[index].subTitle !=
                                    null
                                ? Text(
                                    _multablelistItemPupil[index].subTitle ??
                                        "",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 47, 79, 79)),
                                  )
                                : null,
                          );
                        },
                        separatorBuilder: (_, __) => Divider(),
                        itemCount: _multablelistItemPupil.length,
                      )
                    : Container(
                        alignment: Alignment.topCenter,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Text(
                                  "Nenhum aluno encontrado!\n\nPara realizar o agendamento de um traino é preciso que um aluno seja selecionado.",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Color.fromARGB(255, 47, 79, 79))),
                            ),
                          ],
                        ),
                      ),
              ),
            ]),
          )
        : SizedBox(
            width: double.infinity,
            height: 220,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 30, 20, 30),
              child: Text('Aluno: $pupil',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color.fromARGB(255, 47, 79, 79))),
            ),
          );
  }

  _runPupilFilter(String value) {
    var foundPupils = fullListItemPupil
        .where(
            (pupil) => pupil.title.toLowerCase().contains(value.toLowerCase()))
        .toList();
    setState(() {
      _multablelistItemPupil = List.empty(growable: true);
      _multablelistItemPupil = foundPupils;
    });
  }
}

Future<List<ListSeparatedItem>> fetchAllExercise(String token) async {
  AdministratorService administratorService = AdministratorService();

  List<LoadingDataExercise> listDataExercise =
      await administratorService.fetchAllExercise(token);
  List<ListSeparatedItem> listSeparatedItem = List.empty(growable: true);
  for (var it in listDataExercise) {
    listSeparatedItem.add(
        ListSeparatedItem.fromJson(it.id, it.name, it.muscleGroup, null, null));
  }
  return listSeparatedItem;
}
