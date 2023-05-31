import 'package:flutter/material.dart';
import 'package:workout_app/app/entities/training_entity.dart';
import 'package:workout_app/app/util/dialog.util.dart';
import 'package:workout_app/app/views/home_person_page.dart';
import '../../component/costum_listview_separated.dart';
import '../../component/costum_text_form_field.dart';
import '../../entities/list_separated_item.dart';
import '../../util/costumPadding.dart';

class FindTrainingPage extends StatefulWidget {
  String token;
  Future<List<Training>> listTrainingItem;
  FindTrainingPage(
      {super.key, required this.token, required this.listTrainingItem});

  @override
  State<FindTrainingPage> createState() => _FindTrainingPageState();
}

class _FindTrainingPageState extends State<FindTrainingPage> {
  CostumPadding costumPadding = CostumPadding();

  Message message = Message();

  late List<ListSeparatedItem> fullListItem = List.empty(growable: true);
  List<ListSeparatedItem> _multablelistItem = List.empty(growable: true);

  @override
  void initState() {
    widget.listTrainingItem.then((listTraining) => {
          listTraining.forEach((it) {
            _multablelistItem.add(
                ListSeparatedItem.fromJson(it.id, it.name, null, null, null));
          }),
          fullListItem = _multablelistItem
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).colorScheme.primary;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text('Buscar Treino'),
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
                  FutureBuilder<List<Training>>(
                      future: widget.listTrainingItem,
                      builder:
                          (context, AsyncSnapshot<List<Training>> snapshot) {
                        if (snapshot.hasData) {
                          return SizedBox(
                            width: double.infinity,
                            height: 280,
                            child: _multablelistItem.isNotEmpty
                                ? CostumListViewSeparated(
                                    iconTextField: Icons.edit_note_outlined,
                                    listItem: _multablelistItem,
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
                ],
              ),
            ),
          ),
        ));
  }

  _runFilter(String value) {
    if (value.isNotEmpty) {
      var foundTraining = fullListItem
          .where((training) =>
              training.title.toLowerCase().contains(value.toLowerCase()))
          .toList();
      setState(() {
        _multablelistItem = foundTraining;
      });
    } else {
      setState(() {
        _multablelistItem = fullListItem;
      });
    }
  }
}
