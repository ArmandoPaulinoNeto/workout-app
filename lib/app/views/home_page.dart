import 'package:flutter/material.dart';

import '../controlles/app_controller.dart';

class HomePage extends StatefulWidget {
  String token;
  HomePage({Key? key, required this.token}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          changeTheme(),
        ],
      ),
      body: Center(
        child: GestureDetector(
          child: Text(widget.token),
          onTap: () {
            setState(() {
              count++;
            });
          },
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
