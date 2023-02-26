import 'package:flutter/material.dart';
import 'package:workout_app/app/views/signup_auth_page.dart';

import '../controlles/app_controller.dart';
import 'signin_page.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppController.instance,
      builder: (context, child) {
        return MaterialApp(
          theme: ThemeData(
              primarySwatch: Colors.green,
              brightness: AppController.instance.isDarkTheme
                  ? Brightness.dark
                  : Brightness.light),
          initialRoute: "/",
          routes: {
            "/": (context) => const SigninPage(),
            "/signup-auth": (context) => const SignupAuthPage(),
          },
        );
      },
    );
  }
}
