import 'package:flutter/material.dart';
import '../views/pupil/signup_pupil_page.dart';

class AlertDialogMessage {
  void AlertSignupPupil(
      BuildContext context, String message, String? id, String token) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('Confirme'),
            content: Text(message),
            actions: [
              TextButton(
                  onPressed: () async {
                    Navigator.pop(context, false);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                SignupPupilPage(task: "signup", token: token)));
                  },
                  child: const Text('Cadastrar aluno')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                    Navigator.pop(context);
                  },
                  child: const Text('Sair'))
            ],
          );
        });
  }
}
