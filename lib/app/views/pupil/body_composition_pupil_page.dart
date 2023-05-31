import 'package:flutter/material.dart';
import 'package:workout_app/app/entities/assessment_entity.dart';
import 'package:workout_app/app/views/pupil/body_composition_pupil_page_one.dart';
import '../../controlles/app_controller.dart';
import '../../entities/list_separated_item.dart';
import '../../util/dialog.util.dart';

class BodyCompositionPupilPage extends StatefulWidget {
  String token;
  Future<List<Assessment>> futureListAssessment;
  BodyCompositionPupilPage(
      {Key? key, required this.token, required this.futureListAssessment})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return BodyCompositionPupilPageState();
  }
}

class BodyCompositionPupilPageState extends State<BodyCompositionPupilPage> {
  Message message = Message();
  List<Assessment> listAssessment = List.empty(growable: true);
  List<ListSeparatedItem> listSeparatedItem = List.empty(growable: true);

  @override
  void initState() {
    widget.futureListAssessment.then((listAssessment) {
      this.listAssessment = listAssessment;
      this.listAssessment.forEach(
        (it) {
          listSeparatedItem.add(ListSeparatedItem.fromJson(it.id,
              it.currentWeight.toString(), it.bmi.toString(), null, null));
        },
      );
    });
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
        body: SingleChildScrollView(
          child: Center(
            child: Column(children: [
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
                  child: Container(
                      margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
                      child: Center(
                          child: Text('Avaliações Físicas',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 0, 100, 0))))),
                ),
              ),
              FutureBuilder<List<Assessment>>(
                  future: widget.futureListAssessment,
                  builder: (context, AsyncSnapshot<List<Assessment>> snapshot) {
                    if (snapshot.hasData) {
                      return SizedBox(
                        width: 250,
                        height: 350,
                        child: listSeparatedItem.isNotEmpty
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListView.separated(
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ListTile(
                                      trailing: Wrap(
                                        spacing: 8,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(18),
                                            child: IconButton(
                                              icon: Icon(
                                                Icons.remove_red_eye_sharp,
                                                color: Color.fromARGB(
                                                    255, 0, 100, 0),
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            BodyCompositionPupilOnePage(
                                                                assessment:
                                                                    listAssessment[
                                                                        index])));
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      title: Text(
                                        'Peso atual: ${listSeparatedItem[index].title}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Color.fromARGB(255, 0, 100, 0)),
                                      ),
                                      subtitle:
                                          listSeparatedItem[index].subTitle !=
                                                  null
                                              ? Text(
                                                  'IMC: ${listSeparatedItem[index].subTitle ?? ''}',
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 47, 79, 79)),
                                                )
                                              : null,
                                    );
                                  },
                                  separatorBuilder: (_, __) => Divider(),
                                  itemCount: listSeparatedItem.length,
                                ))
                            : Container(
                                alignment: Alignment.topCenter,
                                child: Text(
                                    "Nenhuma avaliação física encontrada!",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color:
                                            Color.fromARGB(255, 47, 79, 79))),
                              ),
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
            ]),
          ),
        ));
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
