import 'package:flutter/material.dart';
import 'package:workout_app/app/util/dialog.util.dart';
import 'package:workout_app/app/views/home_person_page.dart';

import '../../util/costumPadding.dart';

class FindExercisesPage extends StatefulWidget {
  const FindExercisesPage({super.key});

  @override
  State<FindExercisesPage> createState() => _FindExercisesPageState();
}

class _FindExercisesPageState extends State<FindExercisesPage> {
  CostumPadding costumPadding = CostumPadding();
  Message message = Message();
  var pupils = ["Amando Woler", "Maquiavel", "Jime Gliff", "Emma Watson"];

  String nameExercise = "";
  String muscleGroup = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buscar exercícios'),
        actions: [
          changeTheme(),
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: EdgeInsets.all(20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(
                flex: 1,
                child: TextField(
                  onChanged: (text) {
                    nameExercise = text;
                  },
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      labelText: "Nome do exercício",
                      border: OutlineInputBorder()),
                ),
              ),
              Expanded(
                flex: 1,
                child: TextField(
                  onChanged: (text) {
                    muscleGroup = text;
                  },
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      labelText: "Grupo Muscular",
                      border: OutlineInputBorder()),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  )),
              Center(
                child: Wrap(
                  spacing: 20,
                  children: [
                    Container(
                      // width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () async {}, child: Text("Cadastrar")),
                    ),
                    Container(
                      // width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () async {}, child: Text("Cancelar")),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

listVeiwBuilder(var itemList) {
  return ListView.separated(
    itemBuilder: (BuildContext context, int index) {
      return ListTile(
        trailing: Container(
          width: 48,
          height: 48,
          child: Image(image: AssetImage("assets/images/edit_file_icon.png")),
        ),
        title: Text(itemList[index]),
        subtitle: Text("Ultimo traino: " + index.toString()),
      );
    },
    separatorBuilder: (_, __) => Divider(),
    itemCount: itemList.length,
  );
}
