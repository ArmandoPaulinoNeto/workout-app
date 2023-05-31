import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workout_app/app/util/dialog.util.dart';
import 'package:workout_app/app/views/home_person_page.dart';
import 'package:workout_app/app/views/pupil/signup_pupil_assessment_two_page.dart';
import '../../component/costum_text_form_field.dart';
import '../../util/costumPadding.dart';
import '../../util/currencyFormatter.dart';

class SignupPupilAssessmentOnePage extends StatefulWidget {
  String pupilId;
  String token;
  String pupilBirthday;
  String pupilSex;
  SignupPupilAssessmentOnePage(
      {super.key,
      required this.pupilId,
      required this.pupilBirthday,
      required this.pupilSex,
      required this.token});

  @override
  State<SignupPupilAssessmentOnePage> createState() =>
      _SignupPupilAssessmentOnePageState();
}

class _SignupPupilAssessmentOnePageState
    extends State<SignupPupilAssessmentOnePage> {
  CostumPadding costumPadding = CostumPadding();
  Message inputDialog = Message();

  final _keyForm = GlobalKey<FormState>();
  late String title = "Composição Corporal";
  String inputWeight = "";
  String inputHight = "";
  double weight = 0.0;
  double hight = 0.0;
  double bmi = 0.0;
  String textBMI = "";
  List<TextInputFormatter> inputTextNumber = [
    FilteringTextInputFormatter.digitsOnly,
    CurrencyFormatter()
  ];

  _SignupPupilAssessmentOnePageState() {}

  @override
  void initState() {
    textBMI;
    super.initState();
  }

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
                  label: "Peso:",
                  iconTextField: Icons.monitor_weight,
                  obscureText: false,
                  inputTextNumber: inputTextNumber,
                  validator: (value) {
                    if (value == "0,00") {
                      textBMI = "";
                      return "O campo peso não pode ser vazio.";
                    }
                  },
                  onChanged: (value) {
                    inputWeight = value;
                    if (value != "0,00" &&
                        inputWeight.isNotEmpty &&
                        inputHight.isNotEmpty) {
                      bmi = calcBMI(inputWeight, inputHight);
                    }
                  },
                  onSaved: (value) => {inputWeight = value!},
                  readOnly: false,
                ),
                costumPadding.padding(15),
                CostomTextFormField(
                  label: "Altura:",
                  iconTextField: Icons.high_quality_outlined,
                  obscureText: false,
                  inputTextNumber: inputTextNumber,
                  validator: (value) {
                    if (value == "0,00") {
                      textBMI = "";
                      return "O campo altura não pode ser vazio.";
                    }
                  },
                  onChanged: (value) {
                    inputHight = value;
                    if (value != "0,00" &&
                        inputHight.isNotEmpty &&
                        inputWeight.isNotEmpty) {
                      bmi = calcBMI(inputWeight, inputHight);
                    }
                  },
                  onSaved: (value) => {inputHight = value!},
                  readOnly: false,
                ),
                costumPadding.padding(15),
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
                    child: Center(child: Text('IMC: $textBMI')),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: Theme.of(context).textTheme.labelLarge,
                          ),
                          child: const Text('Continuar',
                              style: TextStyle(
                                fontFamily: AutofillHints.addressCity,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                          onPressed: () {
                            if (_keyForm.currentState!.validate()) {
                              _keyForm.currentState!.save();

                              weight = double.parse(
                                  inputWeight.replaceAll(RegExp(r','), '.'));
                              hight = double.parse(
                                  inputHight.replaceAll(RegExp(r','), '.'));

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          SignupPupilAssessmentTwoPage(
                                            pupilId: widget.pupilId,
                                            pupilBirthday: widget.pupilBirthday,
                                            pupilSex: widget.pupilSex,
                                            weight: weight,
                                            hight: hight,
                                            bmi: bmi,
                                            token: widget.token,
                                          )));
                            }
                          },
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Color.fromARGB(255, 0, 100, 0),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        )));
  }

  double calcBMI(String weight, String hight) {
    var result = double.parse(weight.replaceAll(RegExp(r','), '.')) /
        (double.parse(hight.replaceAll(RegExp(r','), '.')) *
            double.parse(hight.replaceAll(RegExp(r','), '.')));

    result = double.parse((result).toStringAsFixed(2));
    if (result < 18.5) textBMI = "${result.toString()} Abaixo do peso";
    if (result >= 18.5 && result <= 24.9)
      textBMI = "${result.toString()} Peso Normal";
    if (result >= 25 && result <= 29.9)
      textBMI = "${result.toString()} Acima do peso";
    if (result >= 30 && result <= 34.9)
      textBMI = "${result.toString()} Obesidade I";
    if (result >= 35 && result <= 39.9)
      textBMI = "${result.toString()} Obesidade II";
    if (result > 40) textBMI = "${result.toString()} Obesidade III";
    setState(() {
      textBMI;
    });
    return result;
  }
}
