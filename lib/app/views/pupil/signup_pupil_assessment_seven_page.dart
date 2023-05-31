import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workout_app/app/util/dialog.util.dart';
import 'package:workout_app/app/views/home_person_page.dart';
import '../../component/costum_text_form_field.dart';
import '../../services/signup_administrator_service.dart';
import '../../util/costumPadding.dart';

class SignupPupilAssessmentSevenPage extends StatefulWidget {
  double weight;
  double hight;
  String subscapularis;
  String bicipital;
  String thickness;
  String midaxillary;
  String suprailiac;
  String breastplate;
  String abdominal;
  String thigh;
  String calf;
  String fatIdeal;
  double currentFat;
  double fatMass;
  double leanMass;
  String pupilId;
  double bmi;
  String token;
  SignupPupilAssessmentSevenPage(
      {super.key,
      required this.pupilId,
      required this.weight,
      required this.hight,
      required this.bmi,
      required this.subscapularis,
      required this.bicipital,
      required this.thickness,
      required this.midaxillary,
      required this.suprailiac,
      required this.breastplate,
      required this.abdominal,
      required this.thigh,
      required this.calf,
      required this.fatIdeal,
      required this.currentFat,
      required this.fatMass,
      required this.leanMass,
      required this.token});

  @override
  State<SignupPupilAssessmentSevenPage> createState() =>
      _SignupPupilAssessmentSevenPageState();
}

class _SignupPupilAssessmentSevenPageState
    extends State<SignupPupilAssessmentSevenPage> {
  CostumPadding costumPadding = CostumPadding();
  Message inputDialog = Message();

  final _keyForm = GlobalKey<FormState>();
  late String title = "Resistência Muscular Localizada";
  String resultPushUpTest = "Resultado";
  String resultSitUpTest = "Resultado";
  String resultBankOfWells = "Resultado";
  List<TextInputFormatter> inputTextNumber = [
    FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
  ];
  _SignupPupilAssessmentSevenPageState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: [
            changeTheme(),
          ],
        ),
        body: SingleChildScrollView(
            child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _keyForm,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                CostomTextFormField(
                  label: "Teste de Flexão de Braços:",
                  iconTextField: Icons.numbers_rounded,
                  obscureText: false,
                  inputTextNumber: inputTextNumber,
                  onChanged: (value) {
                    var pushUpTest;
                    if (value != "0,00" && value.isNotEmpty) {
                      resultPushUpTest = analyzingPushUpTest(
                          double.parse(value.replaceAll(RegExp(r','), '.')));
                    } else {
                      resultPushUpTest = "Resultado";
                    }
                    setState(() {
                      resultPushUpTest;
                    });
                  },
                  readOnly: false,
                ),
                Card(
                  elevation: 5,
                  margin: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ),
                  child: SizedBox(
                    width: 250,
                    height: 50,
                    child: Center(
                        child: Text('$resultPushUpTest',
                            style: TextStyle(
                                fontFamily: AutofillHints.fullStreetAddress,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 0, 100, 0)))),
                  ),
                ),
                costumPadding.padding(15),
                CostomTextFormField(
                  label: "Teste de Abdominais:",
                  iconTextField: Icons.numbers_rounded,
                  obscureText: false,
                  inputTextNumber: inputTextNumber,
                  onChanged: (value) {
                    if (value != "0,00" && value.isNotEmpty) {
                      resultSitUpTest = analyzingPushUpTest(
                          double.parse(value.replaceAll(RegExp(r','), '.')));
                    } else {
                      resultSitUpTest = "Resultado";
                    }
                    setState(() {
                      resultSitUpTest;
                    });
                  },
                  readOnly: false,
                ),
                Card(
                  elevation: 5,
                  margin: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ),
                  child: SizedBox(
                    width: 250,
                    height: 50,
                    child: Center(
                        child: Text('$resultSitUpTest',
                            style: TextStyle(
                                fontFamily: AutofillHints.fullStreetAddress,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 0, 100, 0)))),
                  ),
                ),
                costumPadding.padding(15),
                CostomTextFormField(
                  label: "Banco de Wells:",
                  iconTextField: Icons.numbers_rounded,
                  obscureText: false,
                  inputTextNumber: inputTextNumber,
                  onChanged: (value) {
                    if (value != "0,00" && value.isNotEmpty) {
                      resultBankOfWells = analyzingPushUpTest(
                          double.parse(value.replaceAll(RegExp(r','), '.')));
                    } else {
                      resultBankOfWells = "Resultado";
                    }
                    setState(() {
                      resultBankOfWells;
                    });
                  },
                  readOnly: false,
                ),
                Card(
                  elevation: 5,
                  margin: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ),
                  child: SizedBox(
                    width: 250,
                    height: 50,
                    child: Center(
                        child: Text('$resultBankOfWells',
                            style: TextStyle(
                                fontFamily: AutofillHints.fullStreetAddress,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 0, 100, 0)))),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: Center(
                    child: Wrap(
                      spacing: 10,
                      children: [
                        Container(
                          child: ElevatedButton.icon(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color.fromARGB(255, 0, 100, 0)),
                              ),
                              onPressed: () {},
                              label: Text("Cancelar"),
                              icon: Icon(Icons.cancel_outlined)),
                        ),
                        Container(
                          child: ElevatedButton.icon(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color.fromARGB(255, 0, 100, 0)),
                              ),
                              onPressed: () async {
                                _AlertSaveAssessment(context);
                              },
                              label: Text("Cadastrar"),
                              icon: Icon(Icons.save)),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        )));
  }

  analyzingPushUpTest(double value) {
    var result = "";

    if (value < 16) result = "RUIM";
    if (value > 16 && value < 22) result = "ABAIXO DA MÉDIA";
    if (value > 21 && value < 29) result = "MÉDIA";
    if (value > 28 && value < 36) result = "ACIMA DA MÉDIA";
    if (value > 35) result = "EXCELENTE";
    return result;
  }

  analyzingSitUpTest(double value) {
    var result = "";

    if (value < 28) result = "RUIM";
    if (value > 28 && value < 33) result = "ABAIXO DA MÉDIA";
    if (value > 32 && value < 37) result = "MÉDIA";
    if (value > 36 && value < 43) result = "ACIMA DA MÉDIA";
    if (value > 42) result = "EXCELENTE";
    return result;
  }

  analyzingBankOfWell(double value) {
    var result = "";

    if (value < 24) result = "RUIM";
    if (value > 24 && value < 30) result = "ABAIXO DA MÉDIA";
    if (value > 29 && value < 34) result = "MÉDIA";
    if (value > 33 && value < 40) result = "ACIMA DA MÉDIA";
    if (value > 39) result = "EXCELENTE";
    return result;
  }

  void _AlertSaveAssessment(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('Confirme'),
            content: const Text('Deseja finalizar a avaliação física?'),
            actions: [
              TextButton(
                  onPressed: () async {
                    SignupAdministratorService signupAdministratorService =
                        SignupAdministratorService();
                    String response =
                        await signupAdministratorService.createAssessment(
                            widget.weight.toString(),
                            widget.hight.toString(),
                            widget.subscapularis,
                            widget.bicipital,
                            widget.thickness,
                            widget.midaxillary,
                            widget.suprailiac,
                            widget.breastplate,
                            widget.abdominal,
                            widget.thigh,
                            widget.calf,
                            widget.fatIdeal.replaceAll(RegExp(r','), '.'),
                            widget.currentFat.toString(),
                            widget.fatMass.toString(),
                            widget.leanMass.toString(),
                            widget.pupilId,
                            widget.bmi.toString(),
                            widget.token);
                    if (!response.contains("falha") ||
                        !response.contains("não autorizado")) {
                      int count = 0;
                      Navigator.popUntil(context, (route) {
                        return count++ == 10;
                      });
                      inputDialog.dialogBuilder(context, "Alerta",
                          "Os dados da avalição física foram salvos com sucesso!");
                    } else {
                      inputDialog.dialogBuilder(context, "Alerta",
                          "Ocorreu uma falha ao tentar salvar os dados do treino!");
                    }
                  },
                  child: const Text('Sim')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Não'))
            ],
          );
        });
  }
}
