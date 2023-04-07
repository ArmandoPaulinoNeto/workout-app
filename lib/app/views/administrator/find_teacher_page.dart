import 'package:flutter/material.dart';
import 'package:workout_app/app/util/dialog.util.dart';
import 'package:workout_app/app/views/home_person_page.dart';
import '../../util/costumPadding.dart';

class FindTeacherPage extends StatefulWidget {
  const FindTeacherPage({super.key});

  @override
  State<FindTeacherPage> createState() => _FindTeacherPageState();
}

class _FindTeacherPageState extends State<FindTeacherPage> {
  CostumPadding costumPadding = CostumPadding();
  Message message = Message();
  var pupils = ["Amando Woler", "Maquiavel", "Jime Gliff", "Emma Watson"];

  String search = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buscar Professor'),
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
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: TextField(
                    onChanged: (text) {
                      search = text;
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Digite o nome do Professor",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  alignment: AlignmentDirectional.centerEnd,
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                  child: ElevatedButton(
                      onPressed: () async {}, child: Text("Pesquisar")),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Text(
                        "Resultados:",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ))),
              Expanded(
                flex: 4,
                child: listVeiwBuilder(pupils),
              )
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
        trailing: Wrap(
          spacing: 2,
          children: [
            Container(
              alignment: AlignmentDirectional.centerEnd,
              width: 48,
              height: 48,
              child:
                  Image(image: AssetImage("assets/images/edit_file_icon.png")),
            ),
            Container(
              alignment: AlignmentDirectional.centerEnd,
              width: 48,
              height: 48,
              child: Image(image: AssetImage("assets/images/delete.png")),
            ),
          ],
        ),
        title: Text(itemList[index]),
        subtitle: Text("Ultimo traino: " + index.toString()),
      );
    },
    separatorBuilder: (_, __) => Divider(),
    itemCount: itemList.length,
  );
}
