import 'package:flutter/material.dart';
import 'package:workout_app/app/views/administrator/signup_teacher_page.dart';
import 'package:workout_app/app/views/pupil/find_pupil_page.dart';
import 'package:workout_app/app/views/pupil/signup_pupil_page.dart';
import 'package:workout_app/app/views/training/signup_training.dart';
import '../component/costum_list_titles.dart';
import '../controlles/app_controller.dart';
import '../entities/loading_data_entity.dart';
import '../util/dialog.util.dart';
import 'administrator/find_execise_page.dart';
import 'administrator/find_teacher_page.dart';
import 'administrator/signup_exercise_page.dart';

class HomePersonPage extends StatefulWidget {
  String token;
  LoadingData loadingData;
  HomePersonPage({Key? key, required this.token, required this.loadingData})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomePersonPageState();
  }
}

class HomePersonPageState extends State<HomePersonPage> {
  Message message = Message();

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
                                token: widget.token,
                              )))
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
                                token: widget.token,
                              )))
                },
                iconTextField: Icons.book_outlined,
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
                              )))
                },
                iconTextField: Icons.search_outlined,
              ),
              CostomListTitles(
                title: "Cadastrar Exercício",
                actionOntap: () => {
                  Navigator.pop(context),
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => SignupExercisePage()))
                },
                iconTextField: Icons.book_outlined,
              ),
              CostomListTitles(
                title: "Buscar Treino",
                actionOntap: () => {
                  Navigator.pop(context),
                  message.dialogBuilder(
                      context, "Mensagem", "Click Buscar Treino.")
                },
                iconTextField: Icons.search_outlined,
              ),
              CostomListTitles(
                title: "Cadastrar Treino",
                actionOntap: () => {
                  Navigator.pop(context),
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => SignupTraining()))
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
                              )))
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
                },
                iconTextField: Icons.book_outlined,
              ),
              CostomListTitles(
                title: "Seu Perfil",
                actionOntap: () => {
                  Navigator.pop(context),
                  message.dialogBuilder(
                      context, "Mensagem", "Click Seu Perfil.")
                },
              )
            ]),
      ),
      appBar: AppBar(
        title: Text(''),
        actions: [
          changeTheme(),
        ],
      ),
      body: SingleChildScrollView(
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
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                child: SizedBox(
                  width: 250,
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 15, 0, 0),
                    child:
                        Text('Olá, ${widget.loadingData.administrator.name}'),
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
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
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
                              image:
                                  AssetImage("assets/images/membership.png"))),
                      Text(widget.loadingData.count.toString())
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
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                child: SizedBox(
                  width: 250,
                  height: 250,
                  child: Container(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Image(
                        image: AssetImage("assets/images/logo_forma.png")),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
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
