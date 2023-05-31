import 'package:flutter/material.dart';
import 'package:workout_app/app/entities/list_separated_item.dart';
import 'package:workout_app/app/entities/loading_data_teacher.dart';
import 'package:workout_app/app/entities/training_entity.dart';
import 'package:workout_app/app/services/administrator_service.dart';
import 'package:workout_app/app/views/administrator/signup_teacher_page.dart';
import 'package:workout_app/app/views/pupil/find_pupil_page.dart';
import 'package:workout_app/app/views/pupil/signup_pupil_page.dart';
import 'package:workout_app/app/views/schedule/signup_schedule_one_page.dart';
import 'package:workout_app/app/views/training/find_training_page.dart';
import 'package:workout_app/app/views/training/signup_training_page.dart';
import '../component/costum_list_titles.dart';
import '../controlles/app_controller.dart';
import '../entities/loading_data_entity.dart';
import '../entities/loading_data_exercise.dart';
import '../entities/loading_data_pupil.dart';
import '../services/pupil_service.dart';
import '../services/signin_service.dart';
import '../services/training_service.dart';
import '../util/dialog.util.dart';
import 'administrator/find_execise_page.dart';
import 'administrator/find_teacher_page.dart';
import 'administrator/signup_exercise_page.dart';

class HomePersonPage extends StatefulWidget {
  String token;
  HomePersonPage({Key? key, required this.token}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomePersonPageState();
  }
}

class HomePersonPageState extends State<HomePersonPage> {
  Message message = Message();
  SigninService signinService = SigninService();
  late Future<LoadingData> futureLoadingData;

  @override
  void initState() {
    futureLoadingData = signinService.getDataHomeAdministrator(widget.token);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 30, 0, 0),
            children: [
              CostomListTitles(
                title: 'Buscar Aluno',
                actionOntap: () => {
                  Navigator.pop(context),
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => FindPupilPage(
                                task: "find",
                                listPupilItem: fetchAllPupil(widget.token),
                                token: widget.token,
                              ))).whenComplete(() => refreshPage())
                },
                iconTextField: Icons.person_search_outlined,
              ),
              CostomListTitles(
                title: "Cadastrar Aluno",
                actionOntap: () => {
                  Navigator.pop(context),
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => SignupPupilPage(
                                task: "signup",
                                token: widget.token,
                              ))).whenComplete(() => refreshPage())
                },
                iconTextField: Icons.book_outlined,
              ),
              CostomListTitles(
                title: 'Avaliação Física',
                actionOntap: () => {
                  Navigator.pop(context),
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => FindPupilPage(
                                task: "assessment",
                                listPupilItem: fetchAllPupil(widget.token),
                                token: widget.token,
                              )))
                },
                iconTextField: Icons.person_search_outlined,
              ),
              CostomListTitles(
                title: "Buscar Exercício",
                actionOntap: () => {
                  Navigator.pop(context),
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => FindExercisePage(
                                token: widget.token,
                                listSeparetedItem:
                                    fetchAllExercise(widget.token),
                              )))
                },
                iconTextField: Icons.search_outlined,
              ),
              CostomListTitles(
                title: "Cadastrar Exercício",
                actionOntap: () => {
                  Navigator.pop(context),
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => SignupExercisePage(
                                token: widget.token,
                              )))
                },
                iconTextField: Icons.book_outlined,
              ),
              CostomListTitles(
                title: "Buscar Treino",
                actionOntap: () => {
                  Navigator.pop(context),
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => FindTrainingPage(
                                token: widget.token,
                                listTrainingItem:
                                    fetchAllTraining(widget.token),
                              )))
                },
                iconTextField: Icons.search_outlined,
              ),
              CostomListTitles(
                title: "Cadastrar Treino",
                actionOntap: () => {
                  Navigator.pop(context),
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              SignupTrainingPage(token: widget.token)))
                },
                iconTextField: Icons.book_outlined,
              ),
              CostomListTitles(
                title: "Buscar Professor",
                actionOntap: () => {
                  Navigator.pop(context),
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => FindTeacherPage(
                                token: widget.token,
                                listSeparetedItem:
                                    fetchAllTeacher(widget.token),
                              ))).whenComplete(() => refreshPage())
                },
                iconTextField: Icons.person_search_outlined,
              ),
              CostomListTitles(
                title: "Cadastrar Professor",
                actionOntap: () => {
                  Navigator.pop(context),
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  SignupTeacherPage(token: widget.token)))
                      .whenComplete(() => refreshPage())
                },
                iconTextField: Icons.book_outlined,
              ),
              CostomListTitles(
                title: "Agendamento",
                actionOntap: () => {
                  Navigator.pop(context),
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => SignupScheduleOnePage(
                              token: widget.token,
                              listTrainingItem: fetchAllTraining(widget.token),
                              listPupilItem: fetchAllPupil(widget.token))))
                },
                iconTextField: Icons.book_outlined,
              ),
              CostomListTitles(
                title: "Sair",
                actionOntap: () =>
                    {Navigator.pop(context), Navigator.pop(context)},
              )
            ]),
      ),
      appBar: AppBar(
        title: Text(''),
        actions: [
          changeTheme(),
        ],
      ),
      body: FutureBuilder<LoadingData>(
          future: futureLoadingData,
          builder: (context, AsyncSnapshot<LoadingData> snapshot) {
            if (snapshot.hasData) {
              LoadingData loadingData = snapshot.data!;
              return SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      Card(
                        elevation: 5,
                        margin: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                        child: SizedBox(
                          width: 250,
                          height: 50,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 15, 0, 0),
                            child:
                                Text('Olá, ${loadingData.administrator.name}'),
                          ),
                        ),
                      ),
                      Card(
                        elevation: 5,
                        margin: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                        child: SizedBox(
                          width: 250,
                          height: 50,
                          child: Row(
                            children: [
                              Container(
                                  width: 48,
                                  height: 48,
                                  padding: EdgeInsets.all(10),
                                  child: Image(
                                      image: AssetImage(
                                          "assets/images/membership.png"))),
                              Text(loadingData.nPupils.toString()),
                              Container(
                                  width: 48,
                                  height: 48,
                                  padding: EdgeInsets.all(10),
                                  child: Icon(
                                    Icons.school_outlined,
                                    color: Color.fromARGB(255, 0, 100, 0),
                                  )),
                              Text(loadingData.nTeachers.toString()),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        elevation: 5,
                        margin: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                        child: SizedBox(
                          width: 250,
                          height: 250,
                          child: Container(
                            alignment: AlignmentDirectional.centerEnd,
                            child: Image(
                                image:
                                    AssetImage("assets/images/logo_forma.png")),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  refreshPage() {
    setState(() {
      futureLoadingData = signinService.getDataHomeAdministrator(widget.token);
    });
  }
}

Future<List<ListSeparatedItem>> fetchAllTeacher(String token) async {
  AdministratorService administratorService = AdministratorService();

  List<LoadingDataTeacher> listDataTeacher =
      await administratorService.fetchAllTeacher(token);
  List<ListSeparatedItem> listSeparatedItem = List.empty(growable: true);
  for (var it in listDataTeacher) {
    listSeparatedItem
        .add(ListSeparatedItem.fromJson(it.id, it.name, it.cref, null, null));
  }
  return listSeparatedItem;
}

Future<List<Training>> fetchAllTraining(String token) async {
  TrainingService trainingService = TrainingService();

  return await trainingService.fetchAllTraining(token);
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

Future<List<LoadingDataPupil>> fetchAllPupil(String token) async {
  PupilService pupilService = PupilService();

  return await pupilService.fetchAllPupil(token);
}

class changeTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Switch(
      value: AppController.instance.isDarkTheme,
      onChanged: (value) {
        AppController.instance.changeTheme();
      },
    );
  }
}
