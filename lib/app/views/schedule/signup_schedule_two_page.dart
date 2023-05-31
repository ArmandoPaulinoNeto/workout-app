import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:workout_app/app/util/dialog.util.dart';
import 'package:workout_app/app/views/home_person_page.dart';
import '../../component/costum_text_form_field.dart';
import '../../entities/exercise_entity.dart';
import '../../entities/list_separated_item.dart';
import '../../entities/training_entity.dart';
import '../../services/signup_service.dart';
import '../../util/costumPadding.dart';

class SignupScheduleTwoPage extends StatefulWidget {
  String token;
  Map<String, String> pupil;
  Training training;
  String trainingDay;
  Future<List<ListSeparatedItem>> listSeparetedItemExecise;

  SignupScheduleTwoPage(
      {super.key,
      required this.token,
      required this.listSeparetedItemExecise,
      required this.training,
      required this.trainingDay,
      required this.pupil});

  @override
  State<SignupScheduleTwoPage> createState() => _SignupScheduleTwoPageState();
}

class _SignupScheduleTwoPageState extends State<SignupScheduleTwoPage> {
  final _keyForm = GlobalKey<FormState>();
  final _keyAlertForm = GlobalKey<FormState>();
  var trainingList = ["SELECIONAR"];
  final List<String> muscleGroupList = <String>[
    "SELECIONAR",
    "COSTAS",
    "PEITO",
    "OMBRO",
    "BÍCEPS",
    "TRÍCEPS",
    "PERNA"
  ];

  String inputName = "";
  String inputRepetition = "";
  String inputSeries = "";
  String inputWeight = "";
  String inputObservatios = "";
  String inputMuscleGroup = "";
  String? _selectedvalue = "";

  CostumPadding costumPadding = CostumPadding();
  Message message = Message();
  late String role;
  List<ListSeparatedItem> fullListItemExercise = List.empty();
  List<ListSeparatedItem> _multablelistItemExercise = List.empty();

  late String name;
  late String id;
  late Training trainingSelected;
  late List<String> exercisesId;
  late List<Exercise> exercises;
  late List<String> repetitions;
  late List<String> series;
  late List<String> weight;
  late List<String> observations;

  @override
  initState() {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(widget.token);
    id = decodedToken['sub'];
    role = decodedToken['role'];
    widget.listSeparetedItemExecise
        .then((listExercise) => fullListItemExercise = listExercise);
    _intializerOrClear();
    super.initState();
  }

  _SignupScheduleTwoPageState() {
    _selectedvalue = muscleGroupList[0];
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
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                        'Aluno: ${widget.pupil['name']}\nTreino: ${widget.training.name}\nDia: ${widget.trainingDay}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color.fromARGB(255, 0, 100, 0))),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                    child: Text("Exercícios:",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color.fromARGB(255, 0, 100, 0))),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 205,
                    child: exercises.isNotEmpty
                        ? ListView.separated(
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                trailing: ClipRRect(
                                  borderRadius: BorderRadius.circular(14),
                                  child: Container(
                                      width: 56,
                                      height: 56,
                                      child: Center(
                                        child: IconButton(
                                          icon: Icon(Icons.remove_circle,
                                              size: 36,
                                              color: Color.fromARGB(
                                                  255, 0, 100, 0)),
                                          onPressed: () {
                                            _deleteExecise(context, index);
                                          },
                                        ),
                                      )),
                                ),
                                title: Text(
                                  exercises[index].name ?? "",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 0, 100, 0)),
                                ),
                                subtitle: exercises[index].muscleGroup != null
                                    ? Text(
                                        "    ${exercises[index].muscleGroup}\n    Series: ${series[index]}\n    Repetições: ${repetitions[index]}\n    Peso: ${weight[index]}",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 47, 79, 79)),
                                      )
                                    : null,
                              );
                            },
                            separatorBuilder: (_, __) => Divider(),
                            itemCount: exercises.length,
                          )
                        : Container(
                            alignment: Alignment.topCenter,
                            margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                            child: Text(
                                "Nenhum exercício adicionado ao treino!",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 47, 79, 79))),
                          ),
                  ),
                  Container(
                    alignment: AlignmentDirectional.centerEnd,
                    width: double.infinity,
                    height: 42,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        width: 42,
                        height: 42,
                        color: Color.fromARGB(255, 0, 100, 0),
                        child: IconButton(
                          icon: Icon(
                            Icons.add_box,
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            await showAvaliabilityMuscleGroup(context);
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
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
                                    _intializerOrClear();
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
                                    if (_keyForm.currentState!.validate() &&
                                        exercises.isNotEmpty) {
                                      _keyForm.currentState!.save();
                                      _AlertSaveSchedule(context);
                                    }
                                    if (exercises.isEmpty) {
                                      message.dialogBuilder(context, "Alerta",
                                          "Verifique se a lista de exercio foi preenchida para o treino!");
                                    }
                                  },
                                  label: Text("Cadastrar"),
                                  icon: Icon(Icons.save)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Future<void> showAvaliabilityMuscleGroup(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Form(
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 30),
                  child: Column(children: [
                    DropdownButtonFormField(
                      value: _selectedvalue,
                      items: muscleGroupList
                          .map((e) => DropdownMenuItem(
                                child: Text(e),
                                value: e,
                              ))
                          .toList(),
                      onChanged: (value) async {
                        _selectedvalue = value as String;
                        if (!value.contains("SELECIONAR")) {
                          Navigator.of(context).pop();
                          inputMuscleGroup = value;
                          _selectedvalue = muscleGroupList[0];
                          _runMuscleGroupFilter(value);
                          await showAvaliabilityListExercice(context);
                        }
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
                        inputMuscleGroup = value!;
                      },
                    ),
                  ]),
                ),
              ),
            ),
          );
        });
  }

  Future<void> showAvaliabilityListExercice(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Selecionar exercício",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Color.fromARGB(255, 0, 100, 0))),
            content: SingleChildScrollView(
              child: Column(children: [
                SizedBox(
                  width: double.infinity,
                  height: 180,
                  child: _multablelistItemExercise.isNotEmpty
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
                                        icon: Icon(Icons.add,
                                            color: Colors.white),
                                        onPressed: () async {
                                          Navigator.of(context).pop();
                                          await showImputsSeriesAndRepetitions(
                                              context,
                                              _multablelistItemExercise[index]
                                                  .id,
                                              _multablelistItemExercise[index]
                                                  .title,
                                              _multablelistItemExercise[index]
                                                  .subTitle);
                                        },
                                      ),
                                    )),
                              ),
                              title: Text(
                                _multablelistItemExercise[index].title,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 0, 100, 0)),
                              ),
                              subtitle: _multablelistItemExercise[index]
                                          .subTitle !=
                                      null
                                  ? Text(
                                      _multablelistItemExercise[index]
                                              .subTitle ??
                                          "",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(255, 47, 79, 79)),
                                    )
                                  : null,
                            );
                          },
                          separatorBuilder: (_, __) => Divider(),
                          itemCount: _multablelistItemExercise.length,
                        )
                      : Container(
                          alignment: Alignment.topCenter,
                          child: Text("Nenhum exercício adicionado ao treino!",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 47, 79, 79))),
                        ),
                ),
              ]),
            ),
          );
        });
  }

  Future<void> showImputsSeriesAndRepetitions(
      BuildContext context,
      String exerciseId,
      String exerciseName,
      String? exerciseMuscleGroup) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Form(
                key: _keyAlertForm,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                      child: Center(
                        child: Text("Selecionar Séries e repetições",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Color.fromARGB(255, 0, 100, 0))),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                      child: CostomTextFormField(
                        label: "Repetições:",
                        iconTextField: Icons.task_alt,
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "O campo repetições não pode ser vazio.";
                          }
                        },
                        onSaved: (value) => {inputRepetition = value!},
                        readOnly: false,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                      child: Container(
                        width: 190,
                        child: CostomTextFormField(
                          label: "Séries:",
                          iconTextField: Icons.task_alt,
                          obscureText: false,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "O campo séries não pode ser vazio.";
                            }
                          },
                          onSaved: (value) => {inputSeries = value!},
                          readOnly: false,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                      child: Container(
                        width: 190,
                        child: CostomTextFormField(
                          label: "Peso:",
                          iconTextField: Icons.task_alt,
                          obscureText: false,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "O campo peso não pode ser vazio.";
                            }
                          },
                          onSaved: (value) => {inputWeight = value!},
                          readOnly: false,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: CostomTextFormField(
                        label: "Observações:",
                        iconTextField: Icons.perm_contact_calendar_outlined,
                        obscureText: false,
                        onSaved: (value) => {inputObservatios = value ?? ""},
                        readOnly: false,
                      ),
                    ),
                    Container(
                      child: ElevatedButton.icon(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 0, 100, 0)),
                          ),
                          onPressed: () {
                            if (_keyAlertForm.currentState!.validate()) {
                              _keyAlertForm.currentState!.save();
                              Navigator.of(context).pop();
                              Exercise exercise = Exercise(
                                  id: exerciseId,
                                  name: exerciseName,
                                  muscleGroup: exerciseMuscleGroup ?? "");
                              setState(() {
                                name = inputName;
                                exercises.add(exercise);
                                repetitions.add(inputRepetition);
                                series.add(inputSeries);
                                weight.add(inputWeight);
                                observations.add(inputObservatios);
                              });
                            }
                          },
                          label: Text("Adicionar"),
                          icon: Icon(Icons.add_circle)),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  _runMuscleGroupFilter(String value) {
    var foundExercises = fullListItemExercise
        .where((teacher) =>
            teacher.subTitle!.toLowerCase().contains(value.toLowerCase()))
        .toList();
    setState(() {
      _multablelistItemExercise = foundExercises;
    });
  }

  void _deleteExecise(BuildContext context, int index) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('Confirme'),
            content: const Text('Deseja realmente remover este exercício?'),
            actions: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      exercises.removeAt(index);
                      repetitions.removeAt(index);
                      series.removeAt(index);
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text('Sim')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Não'))
            ],
          );
        });
  }

  void _AlertSaveSchedule(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('Confirme'),
            content: const Text('Deseja finalizar o cadastro do treino?'),
            actions: [
              TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                    exercisesId = List.generate(
                        exercises.length, (index) => exercises[index].id!,
                        growable: true);
                    SignupService signupService = SignupService();
                    String response = await signupService.createSchedule(
                        widget.pupil['id']!,
                        widget.trainingDay,
                        id,
                        repetitions,
                        series,
                        weight,
                        observations,
                        widget.training.id!,
                        exercisesId,
                        widget.token);
                    if (!response.contains("falha") ||
                        !response.contains("não autorizado")) {
                      Navigator.of(context).pop();
                    } else {
                      message.dialogBuilder(context, "Alerta",
                          "Ocorreu uma falha ao tentar salvar os dados do treino!");
                    }
                  },
                  child: const Text('Sim')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Não'))
            ],
          );
        });
  }

  _intializerOrClear() {
    setState(() {
      exercises = List.empty(growable: true);
      repetitions = List.empty(growable: true);
      series = List.empty(growable: true);
      weight = List.empty(growable: true);
      observations = List.empty(growable: true);
    });
  }
}
