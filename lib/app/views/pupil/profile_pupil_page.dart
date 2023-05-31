import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:workout_app/app/util/dialog.util.dart';
import '../../controlles/app_controller.dart';
import '../../entities/person_logged.dart';
import '../../util/convert-base64.dart';
import '../../util/costumPadding.dart';

class ProfilePupilPage extends StatefulWidget {
  PersonLogged pupilLogged;
  ProfilePupilPage({Key? key, required this.pupilLogged}) : super(key: key);

  @override
  State<ProfilePupilPage> createState() => _ProfilePupilPageState();
}

class _ProfilePupilPageState extends State<ProfilePupilPage> {
  CostumPadding costumPadding = CostumPadding();
  Message message = Message();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Perfil'),
          actions: [
            changeTheme(),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: Image.memory(base64Decode(
                                  widget.pupilLogged.pupil!.photo!))
                              .image)),
                ),
                Text(
                  "Nome",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
                Text(
                  widget.pupilLogged.pupil!.name!,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 100, 0)),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 4, 0, 0),
                  child: Text(
                    "Objetivo",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54),
                  ),
                ),
                Text(widget.pupilLogged.pupil!.goal!,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 100, 0))),
              ],
            ),
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
