import 'package:flutter/material.dart';
import '../controlles/app_controller.dart';
import '../entities/loading_data_pupil.dart';
import '../services/signin_service.dart';
import '../util/dialog.util.dart';

class HomePupilPage extends StatefulWidget {
  String token;
  HomePupilPage({Key? key, required this.token}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomePupilPageState();
  }
}

class HomePupilPageState extends State<HomePupilPage> {
  Message message = Message();
  SigninService signinService = SigninService();
  late Future<LoadingDataPupil> futureLoadingDataPupil;

  @override
  void initState() {
    futureLoadingDataPupil = signinService.getDataHomePupil(widget.token);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        actions: [
          changeTheme(),
        ],
      ),
      body: FutureBuilder<LoadingDataPupil>(
          future: futureLoadingDataPupil,
          builder: (context, AsyncSnapshot<LoadingDataPupil> snapshot) {
            if (snapshot.hasData) {
              LoadingDataPupil loadingDataPupil = snapshot.data!;
              return SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      Card(
                        elevation: 5,
                        margin: EdgeInsets.all(5),
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
                            child: Text('Olá, ${loadingDataPupil.pupil?.name}'),
                          ),
                        ),
                      ),
                      Card(
                        elevation: 5,
                        margin: EdgeInsets.all(5),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                        child: SizedBox(
                          width: 250,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'Seu último traino: ${loadingDataPupil.pupil!.lastTraining ?? "..."}'),
                                Text(
                                    'Altura: ${loadingDataPupil.pupil!.weight ?? "..."}'),
                                Text(
                                    'Peso: ${loadingDataPupil.pupil!.hight ?? "..."}'),
                              ],
                            ),
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
