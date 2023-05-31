import 'package:flutter/material.dart';
import 'package:workout_app/app/util/alert_signup_pupil.dart';
import 'package:workout_app/app/views/home_person_page.dart';
import 'package:workout_app/app/views/pupil/signup_pupil_assessment_page.dart';
import 'package:workout_app/app/views/pupil/signup_pupil_page.dart';
import '../../component/costum_text_form_field.dart';
import '../../entities/list_separated_item.dart';
import '../../entities/loading_data_pupil.dart';
import '../../entities/pupil_entity.dart';
import '../../services/pupil_service.dart';
import '../../util/costumPadding.dart';
import '../../util/dialog.util.dart';

class FindPupilPage extends StatefulWidget {
  String token;
  String task;
  Future<List<LoadingDataPupil>> listPupilItem;
  FindPupilPage(
      {super.key,
      required this.token,
      required this.task,
      required this.listPupilItem});

  @override
  State<FindPupilPage> createState() => _FindPupilPageState();
}

class _FindPupilPageState extends State<FindPupilPage> {
  CostumPadding costumPadding = CostumPadding();
  late List<ListSeparatedItem> fullListItemPupil = List.empty(growable: true);
  List<ListSeparatedItem> _multablelistItemPupil = List.empty(growable: true);
  Message inputDialog = Message();
  late String title =
      widget.task == "find" ? "Buscar Aluno" : "Avalialiação Física";
  late String message;

  @override
  void initState() {
    widget.listPupilItem.then((listPupil) => {
          if (listPupil.isNotEmpty)
            {
              listPupil.forEach((it) {
                fullListItemPupil.add(ListSeparatedItem.fromJson(it.pupil?.id,
                    it.pupil?.name, null, it.pupil?.birthday, it.pupil?.sex));
              }),
              _multablelistItemPupil = fullListItemPupil
            }
          else
            {
              message =
                  "Nenhum registro encontrado!\n\nDeseja realizar o cadastrado de um aluno?",
              AlertDialogMessage()
                  .AlertSignupPupil(context, message, null, widget.token)
            }
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(title),
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
                    onChanged: (value) => _runFilter(value),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 30, 160, 15),
                    child: Text("Resultados:",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color.fromARGB(255, 0, 100, 0))),
                  ),
                  FutureBuilder<List<LoadingDataPupil>>(
                      future: widget.listPupilItem,
                      builder: (context,
                          AsyncSnapshot<List<LoadingDataPupil>> snapshot) {
                        if (snapshot.hasData) {
                          return SizedBox(
                            width: double.infinity,
                            height: 280,
                            child: _multablelistItemPupil.isNotEmpty
                                ? ListView.separated(
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return ListTile(
                                        trailing: Wrap(
                                          spacing: 8,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(18),
                                              child: Container(
                                                  width: 36,
                                                  height: 36,
                                                  color: Color.fromARGB(
                                                      255, 0, 100, 0),
                                                  child: Center(
                                                    child: IconButton(
                                                      icon: Icon(
                                                        widget.task.contains(
                                                                "find")
                                                            ? Icons
                                                                .edit_note_outlined
                                                            : Icons.add,
                                                        color: Colors.white,
                                                      ),
                                                      onPressed: () {
                                                        if (widget.task
                                                            .contains("find")) {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (_) => SignupPupilPage(
                                                                      pupil: findById(
                                                                          _multablelistItemPupil[index]
                                                                              .id,
                                                                          widget
                                                                              .token),
                                                                      task:
                                                                          "update",
                                                                      token: widget
                                                                          .token)));
                                                        } else {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (_) => SignupPupilAssessmentPage(
                                                                      pupilId:
                                                                          _multablelistItemPupil[index]
                                                                              .id,
                                                                      pupilBirthday:
                                                                          _multablelistItemPupil[index]
                                                                              .date!,
                                                                      pupilSex:
                                                                          _multablelistItemPupil[index]
                                                                              .sex!,
                                                                      token: widget
                                                                          .token)));
                                                        }
                                                      },
                                                    ),
                                                  )),
                                            ),
                                            widget.task.contains("find")
                                                ? ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            9),
                                                    child: Container(
                                                      width: 36,
                                                      height: 36,
                                                      color: Color.fromARGB(
                                                          255, 0, 100, 0),
                                                      child: IconButton(
                                                        icon: Icon(
                                                          Icons.delete,
                                                          color: Colors.white,
                                                        ),
                                                        onPressed: () {
                                                          message =
                                                              "Deseja deletar os dados do aluno: ${_multablelistItemPupil[index].title} permanentemente?";
                                                          AlertConfirmDeletePupil(
                                                              context,
                                                              message,
                                                              _multablelistItemPupil[
                                                                      index]
                                                                  .id,
                                                              widget.token);
                                                        },
                                                      ),
                                                    ),
                                                  )
                                                : Text(""),
                                          ],
                                        ),
                                        title: Text(
                                          _multablelistItemPupil[index].title,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 0, 100, 0)),
                                        ),
                                        subtitle: _multablelistItemPupil[index]
                                                    .subTitle !=
                                                null
                                            ? Text(
                                                _multablelistItemPupil[index]
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
                                    itemCount: _multablelistItemPupil.length,
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

  Future<Pupil> findById(String id, String token) async {
    PupilService pupilService = PupilService();

    return await pupilService.findById(id, token);
  }

  AlertConfirmDeletePupil(
      BuildContext context, String message, String id, String token) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('Confirme'),
            content: Text(message),
            actions: [
              TextButton(
                  onPressed: () async {
                    PupilService pupilService = PupilService();
                    String response =
                        await pupilService.deletePupil(id, widget.token);
                    if (!response.contains("falha") ||
                        !response.contains("não autorizado")) {
                      inputDialog.dialogBuilder(context, "Alerta",
                          "Os dados do aluno foram deletados corretamente!");
                    } else {
                      inputDialog.dialogBuilder(context, "Alerta",
                          "Erro ao deletar os dados do aluno!");
                    }
                  },
                  child: const Text('Deletar aluno?')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('Sair'))
            ],
          );
        });
  }

  _runFilter(String value) {
    if (value.isNotEmpty) {
      var foundPupils = fullListItemPupil
          .where((pupil) =>
              pupil.title.toLowerCase().contains(value.toLowerCase()))
          .toList();
      setState(() {
        _multablelistItemPupil = foundPupils;
      });
    } else {
      setState(() {
        _multablelistItemPupil = fullListItemPupil;
      });
    }
  }
}
