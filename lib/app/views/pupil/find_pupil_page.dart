import 'package:flutter/material.dart';
import 'package:workout_app/app/util/dialog.util.dart';
import 'package:workout_app/app/views/home_person_page.dart';
import '../../component/costum_listview_separated.dart';
import '../../component/costum_text_form_field.dart';
import '../../entities/list_separated_item.dart';
import '../../util/costumPadding.dart';

class FindPupilPage extends StatefulWidget {
  String token;
  Future<List<ListSeparatedItem>> listSeparetedItem;
  FindPupilPage(
      {super.key, required this.token, required this.listSeparetedItem});

  @override
  State<FindPupilPage> createState() => _FindPupilPageState();
}

class _FindPupilPageState extends State<FindPupilPage> {
  CostumPadding costumPadding = CostumPadding();
  late List<ListSeparatedItem> fullListItem = List.empty();
  List<ListSeparatedItem> _multablelistItem = List.empty();
  Message message = Message();

  @override
  void initState() {
    widget.listSeparetedItem.then((listPupil) => _multablelistItem = listPupil);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text('Buscar Aluno'),
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
                  FutureBuilder<List<ListSeparatedItem>>(
                      future: widget.listSeparetedItem,
                      builder: (context,
                          AsyncSnapshot<List<ListSeparatedItem>> snapshot) {
                        if (snapshot.hasData) {
                          fullListItem = snapshot.data!;
                          return SizedBox(
                            width: double.infinity,
                            height: 280,
                            child: _multablelistItem.isNotEmpty
                                ? CostumListViewSeparated(
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
      var foundPupils = fullListItem
          .where((pupil) =>
              pupil.title.toLowerCase().contains(value.toLowerCase()))
          .toList();
      setState(() {
        _multablelistItem = foundPupils;
      });
    } else {
      setState(() {
        _multablelistItem = fullListItem;
      });
    }
  }
}
