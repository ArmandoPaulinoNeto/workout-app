import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workout_app/app/util/dialog.util.dart';
import 'package:workout_app/app/views/home_person_page.dart';
import '../../component/costum_text_form_field.dart';
import '../../entities/schedule_entity.dart';
import '../../services/pupil_service.dart';
import '../../util/costumPadding.dart';
import '../../util/currencyFormatter.dart';

class ViewSchedulePupilPage extends StatefulWidget {
  String token;
  String scheduleId;
  ViewSchedulePupilPage(
      {super.key, required this.scheduleId, required this.token});

  @override
  State<ViewSchedulePupilPage> createState() => _ViewSchedulePupilPageState();
}

class _ViewSchedulePupilPageState extends State<ViewSchedulePupilPage> {
  final _keyAlertForm = GlobalKey<FormState>();
  CostumPadding costumPadding = CostumPadding();

  Message inputMessege = Message();
  late String message;
  String inputWeight = "";
  late Future<Schedule> futureSchedule =
      findByScheduleId(widget.scheduleId, widget.token);
  late Schedule schedule;

  @override
  void initState() {
    futureSchedule.then((value) {
      schedule = value;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).colorScheme.primary;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text('Treino Agendado'),
          actions: [
            changeTheme(),
          ],
        ),
        body: SingleChildScrollView(
          child: Form(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 15, 20, 10),
              child: FutureBuilder<Schedule>(
                  future: futureSchedule,
                  builder: (context, AsyncSnapshot<Schedule> snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: Column(
                              children: [
                                Text(
                                  "Traino: ${schedule.nameTraining}",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 0, 100, 0),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Text(
                                  "Dia do Traino: ${schedule.trainingDay}",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 0, 100, 0),
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 350,
                            child: ListView.separated(
                              itemBuilder: (BuildContext context, int index) {
                                return Card(
                                  elevation: 5,
                                  margin: EdgeInsets.all(10),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8)),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "Exercício: ${schedule.exercises![index].name}",
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 0, 100, 0),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "Grupo Muscular: ${schedule.exercises![index].muscleGroup}",
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 0, 100, 0),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        // Horizontal ListView
                                        height: 40,
                                        child: ListView(
                                            scrollDirection: Axis.horizontal,
                                            children: [
                                              Container(
                                                height: 30,
                                                margin: EdgeInsets.all(2.0),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: Colors.blue[50]),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                      "Séries: ${schedule.series![index]}",
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 0, 100, 0),
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                              ),
                                              Container(
                                                height: 30,
                                                margin: EdgeInsets.all(2.0),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: Colors.blue[100]),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                      "Repetições: ${schedule.repetitions![index]}",
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 0, 100, 0),
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                              ),
                                              Container(
                                                height: 30,
                                                margin: EdgeInsets.all(2.0),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: Colors.blue[200]),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: ElevatedButton.icon(
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStatePropertyAll(
                                                              Colors.blue[200]),
                                                    ),
                                                    onPressed: () {
                                                      showInputEditWeight(
                                                          context,
                                                          schedule.trainingExerciseFK![
                                                              index]);
                                                    },
                                                    icon: Icon(
                                                      // <-- Icon
                                                      Icons.edit,
                                                      size: 24.0,
                                                    ),
                                                    label: Text(
                                                        "Peso: ${schedule.weight![index]}",
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    0,
                                                                    100,
                                                                    0),
                                                            fontWeight: FontWeight
                                                                .bold)), // <-- Text
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: 30,
                                                margin: EdgeInsets.all(2.0),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: Colors.green[300]),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                      "Observação: ${schedule.observations![index]}",
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 0, 100, 0),
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                              )
                                            ]),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (_, __) => Divider(),
                              itemCount: schedule.exercises!.length,
                            ),
                          )
                        ],
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
          ),
        ));
  }

  Future<Schedule> findByScheduleId(scheduleId, String token) async {
    PupilService pupilService = PupilService();
    return await pupilService.findByScheduleId(scheduleId, token);
  }

  Future<void> showInputEditWeight(BuildContext context, String id) async {
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
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                      child: CostomTextFormField(
                        label: "Peso:",
                        iconTextField: Icons.scale_outlined,
                        obscureText: false,
                        inputTextNumber: [
                          FilteringTextInputFormatter.digitsOnly,
                          CurrencyFormatter()
                        ],
                        validator: (value) {
                          if (value == "0,00") {
                            return "O campo peso não pode ser vazio.";
                          }
                        },
                        onSaved: (value) => {
                          inputWeight = value!.replaceAll(RegExp(r','), '.')
                        },
                        readOnly: false,
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Wrap(
                          spacing: 2,
                          children: [
                            Container(
                              child: ElevatedButton.icon(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Color.fromARGB(255, 0, 100, 0)),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
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
                                    if (_keyAlertForm.currentState!
                                        .validate()) {
                                      _keyAlertForm.currentState!.save();
                                      PupilService pupilService =
                                          PupilService();
                                      int response = await pupilService
                                          .updateTrainingPupil(
                                              id, inputWeight, widget.token);
                                      if (response == 200 || response == 201) {
                                        Navigator.of(context).pop();
                                        inputMessege.dialogBuilder(
                                            context,
                                            "Alerta",
                                            "O exercício foi atualizado com sucesso!");
                                        setState(() {
                                          futureSchedule = findByScheduleId(
                                              widget.scheduleId, widget.token);
                                        });
                                      } else {
                                        Navigator.of(context).pop();
                                        inputMessege.dialogBuilder(
                                            context,
                                            "Alerta",
                                            "Ocorreu uma falha ao atualizar o exercício!");
                                      }
                                    }
                                  },
                                  label: Text("Finalizar"),
                                  icon: Icon(Icons.save)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
