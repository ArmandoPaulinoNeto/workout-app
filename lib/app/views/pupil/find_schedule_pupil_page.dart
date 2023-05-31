import 'package:flutter/material.dart';
import 'package:workout_app/app/util/dialog.util.dart';
import 'package:workout_app/app/views/home_person_page.dart';
import 'package:workout_app/app/views/pupil/view_schedule_pupil_page.dart';
import '../../entities/list_separated_item.dart';
import '../../entities/schedule_entity.dart';
import '../../services/pupil_service.dart';
import '../../util/costumPadding.dart';

class FindSchedulePupilPage extends StatefulWidget {
  String token;
  FindSchedulePupilPage({super.key, required this.token});

  @override
  State<FindSchedulePupilPage> createState() => _FindSchedulePupilPageState();
}

class _FindSchedulePupilPageState extends State<FindSchedulePupilPage> {
  CostumPadding costumPadding = CostumPadding();

  Message inputMessege = Message();
  late String message;
  late Future<List<Schedule>> listSeparetedItem;
  List<ListSeparatedItem> _multablelistItem = List.empty(growable: true);

  @override
  void initState() {
    listSeparetedItem = getSchedulePupil(widget.token);
    listSeparetedItem.then((listSchedule) => {
          if (listSchedule.isNotEmpty)
            {
              listSchedule.forEach((it) {
                _multablelistItem.add(ListSeparatedItem.fromJson(
                    it.id, it.nameTraining, it.trainingDay, null, null));
              })
            }
          else
            {
              inputMessege.dialogBuilder(
                  context, "Alerta", "Nenhum agendamento de treino encontrado!")
            }
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
              child: Column(
                children: [
                  FutureBuilder<List<Schedule>>(
                      future: listSeparetedItem,
                      builder:
                          (context, AsyncSnapshot<List<Schedule>> snapshot) {
                        if (snapshot.hasData) {
                          return SizedBox(
                            width: double.infinity,
                            height: 280,
                            child: _multablelistItem.isNotEmpty
                                ? ListView.separated(
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return ListTile(
                                        trailing: Wrap(
                                          spacing: 2,
                                          children: [
                                            IconButton(
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
                                                            ViewSchedulePupilPage(
                                                                scheduleId:
                                                                    _multablelistItem[
                                                                            index]
                                                                        .id,
                                                                token: widget
                                                                    .token)));
                                              },
                                            ),
                                            IconButton(
                                              icon: Icon(
                                                Icons.check_circle_sharp,
                                                color: Color.fromARGB(
                                                    255, 0, 100, 0),
                                              ),
                                              onPressed: () {},
                                            ),
                                          ],
                                        ),
                                        title: Text(
                                          _multablelistItem[index].title,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 0, 100, 0)),
                                        ),
                                        subtitle:
                                            _multablelistItem[index].subTitle !=
                                                    null
                                                ? Text(
                                                    _multablelistItem[index]
                                                            .subTitle ??
                                                        "",
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 47, 79, 79)),
                                                  )
                                                : null,
                                      );
                                    },
                                    separatorBuilder: (_, __) => Divider(),
                                    itemCount: _multablelistItem.length,
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
                          return Center(child: CircularProgressIndicator());
                        }
                      }),
                ],
              ),
            ),
          ),
        ));
  }

  Future<List<Schedule>> getSchedulePupil(String token) async {
    PupilService pupilService = PupilService();
    return await pupilService.getSchedulePupil(token);
  }
}
