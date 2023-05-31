import 'package:intl/intl.dart';

class FindAgeByBirthday {
  findAge(String pupilBirthday) {
    String date =
        DateFormat("dd/MM/yyyy").format(DateTime.parse(pupilBirthday));
    List<String> campos = date.split('/');
    int dia = int.parse(campos[0]);
    int mes = int.parse(campos[1]);
    int ano = int.parse(campos[2]);
    DateTime nascimento = DateTime(ano, mes, dia);
    DateTime hoje = DateTime.now();
    return hoje.difference(nascimento).inDays ~/ 365.25;
  }
}
