import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workout_app/app/util/dialog.util.dart';
import 'package:workout_app/app/views/home_person_page.dart';
import 'package:workout_app/app/views/pupil/signup_pupil_assessment_three_page.dart';
import '../../component/costum_text_form_field.dart';
import '../../entities/assessment_entity.dart';
import '../../util/costumPadding.dart';
import '../../util/find_age_by_birthday.dart';

class SignupPupilAssessmentTwoPage extends StatefulWidget {
  String pupilId;
  String pupilBirthday;
  String pupilSex;
  double weight;
  double hight;
  double bmi;
  String token;
  SignupPupilAssessmentTwoPage(
      {super.key,
      required this.pupilId,
      required this.pupilBirthday,
      required this.pupilSex,
      required this.weight,
      required this.hight,
      required this.bmi,
      required this.token});

  @override
  State<SignupPupilAssessmentTwoPage> createState() =>
      _SignupPupilAssessmentTwoPageState();
}

class _SignupPupilAssessmentTwoPageState
    extends State<SignupPupilAssessmentTwoPage> {
  CostumPadding costumPadding = CostumPadding();
  Message inputDialog = Message();

  final _keyForm = GlobalKey<FormState>();
  late String title = "Dobras Cutâneas";
  late String subscapularis;
  late String bicipital;
  late String thickness;
  late String midaxillary;
  late String suprailiac;
  late String breastplate;
  late String abdominal;
  late String thigh;
  late String calf;
  List<TextInputFormatter> inputTextNumber = [
    FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
  ];

  _SignupPupilAssessmentTwoPageState() {}

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
                  label: "Subescapular:",
                  iconTextField: Icons.numbers_outlined,
                  obscureText: false,
                  inputTextNumber: inputTextNumber,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "O campo subescapular não pode ser vazio.";
                    }
                  },
                  onSaved: (value) => {subscapularis = value!},
                  readOnly: false,
                ),
                costumPadding.padding(15),
                CostomTextFormField(
                  label: "Bicipital:",
                  iconTextField: Icons.numbers_outlined,
                  obscureText: false,
                  inputTextNumber: inputTextNumber,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "O campo bicipital não pode ser vazio.";
                    }
                  },
                  onSaved: (value) => {bicipital = value!},
                  readOnly: false,
                ),
                costumPadding.padding(15),
                CostomTextFormField(
                  label: "Tricipital:",
                  iconTextField: Icons.numbers_outlined,
                  obscureText: false,
                  inputTextNumber: inputTextNumber,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "O campo tricipital não pode ser vazio.";
                    }
                  },
                  onSaved: (value) => {thickness = value!},
                  readOnly: false,
                ),
                costumPadding.padding(15),
                CostomTextFormField(
                  label: "Auxíliar-média:",
                  iconTextField: Icons.numbers_rounded,
                  obscureText: false,
                  inputTextNumber: inputTextNumber,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "O campo auxíliar-média não pode ser vazio.";
                    }
                  },
                  onSaved: (value) => {midaxillary = value!},
                  readOnly: false,
                ),
                costumPadding.padding(15),
                CostomTextFormField(
                  label: "Supra-ilíaca:",
                  iconTextField: Icons.numbers_outlined,
                  obscureText: false,
                  inputTextNumber: inputTextNumber,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "O campo supra-ilíaca não pode ser vazio.";
                    }
                  },
                  onSaved: (value) => {suprailiac = value!},
                  readOnly: false,
                ),
                costumPadding.padding(15),
                CostomTextFormField(
                  label: "Peitoral:",
                  iconTextField: Icons.numbers_outlined,
                  obscureText: false,
                  inputTextNumber: inputTextNumber,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "O campo peitoral não pode ser vazio.";
                    }
                  },
                  onSaved: (value) => {breastplate = value!},
                  readOnly: false,
                ),
                costumPadding.padding(15),
                CostomTextFormField(
                  label: "Abdominal:",
                  iconTextField: Icons.numbers_outlined,
                  obscureText: false,
                  inputTextNumber: inputTextNumber,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "O campo abdominal não pode ser vazio.";
                    }
                  },
                  onSaved: (value) => {abdominal = value!},
                  readOnly: false,
                ),
                costumPadding.padding(15),
                CostomTextFormField(
                  label: "Coxa:",
                  iconTextField: Icons.numbers_outlined,
                  obscureText: false,
                  inputTextNumber: inputTextNumber,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "O campo coxa não pode ser vazio.";
                    }
                  },
                  onSaved: (value) => {thigh = value!},
                  readOnly: false,
                ),
                costumPadding.padding(15),
                CostomTextFormField(
                  label: "Panturrilha:",
                  iconTextField: Icons.numbers_outlined,
                  obscureText: false,
                  inputTextNumber: inputTextNumber,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "O campo panturrilha não pode ser vazio.";
                    }
                  },
                  onSaved: (value) => {calf = value!},
                  readOnly: false,
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
                              Assessment assessment = Assessment();
                              int age = FindAgeByBirthday()
                                  .findAge(widget.pupilBirthday);
                              double currentFat =
                                  assessment.pollockSevenSkinFolds(
                                      subscapularis,
                                      thickness,
                                      midaxillary,
                                      suprailiac,
                                      breastplate,
                                      abdominal,
                                      thigh,
                                      age);
                              double fatMass = assessment.calcFatMass(
                                  widget.weight, currentFat);
                              double leanMass = assessment.calcLeanMass(
                                  widget.weight, fatMass);

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          SignupPupilAssessmentThreePage(
                                            pupilId: widget.pupilId,
                                            pupilAge: age,
                                            pupilSex: widget.pupilSex,
                                            weight: widget.weight,
                                            hight: widget.hight,
                                            bmi: widget.bmi,
                                            subscapularis: subscapularis,
                                            bicipital: bicipital,
                                            thickness: thickness,
                                            midaxillary: midaxillary,
                                            suprailiac: suprailiac,
                                            breastplate: breastplate,
                                            abdominal: abdominal,
                                            thigh: thigh,
                                            calf: calf,
                                            currentFat: currentFat,
                                            fatMass: fatMass,
                                            leanMass: leanMass,
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
}
