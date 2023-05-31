import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workout_app/app/util/dialog.util.dart';
import 'package:workout_app/app/views/home_person_page.dart';
import 'package:workout_app/app/views/pupil/signup_pupil_assessment_six_page.dart';
import '../../component/costum_text_form_field.dart';
import '../../util/costumPadding.dart';
import '../../util/currencyFormatter.dart';

class SignupPupilAssessmentFivePage extends StatefulWidget {
  String pupilId;
  double weight;
  double hight;
  double bmi;
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
  String relationEntreWaistAndHip;
  String token;
  SignupPupilAssessmentFivePage(
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
      required this.currentFat,
      required this.fatMass,
      required this.leanMass,
      required this.relationEntreWaistAndHip,
      required this.token,
      required this.fatIdeal});

  @override
  State<SignupPupilAssessmentFivePage> createState() =>
      _SignupPupilAssessmentFivePageState();
}

class _SignupPupilAssessmentFivePageState
    extends State<SignupPupilAssessmentFivePage> {
  CostumPadding costumPadding = CostumPadding();
  Message inputDialog = Message();

  final _keyForm = GlobalKey<FormState>();
  late String title = "Direito(à)";
  late String forearmRight;
  late String relaxedArmRight;
  late String contractedArmRight;
  late String thighRight;
  late String calf1Right;
  List<TextInputFormatter> inputTextNumber = [
    FilteringTextInputFormatter.digitsOnly,
    CurrencyFormatter()
  ];
  _SignupPupilAssessmentFivePageState() {}

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
                  label: "Antebraço:",
                  iconTextField: Icons.numbers_outlined,
                  obscureText: false,
                  inputTextNumber: inputTextNumber,
                  onSaved: (value) => {forearmRight = value!},
                  readOnly: false,
                ),
                costumPadding.padding(15),
                CostomTextFormField(
                  label: "Braço Relaxado:",
                  iconTextField: Icons.numbers_rounded,
                  obscureText: false,
                  inputTextNumber: inputTextNumber,
                  onSaved: (value) => {relaxedArmRight = value!},
                  readOnly: false,
                ),
                costumPadding.padding(15),
                CostomTextFormField(
                  label: "Braço Contraído:",
                  iconTextField: Icons.numbers_rounded,
                  obscureText: false,
                  inputTextNumber: inputTextNumber,
                  onSaved: (value) => {contractedArmRight = value!},
                  readOnly: false,
                ),
                costumPadding.padding(15),
                CostomTextFormField(
                  label: "Coxa:",
                  iconTextField: Icons.numbers_outlined,
                  obscureText: false,
                  inputTextNumber: inputTextNumber,
                  onSaved: (value) => {thighRight = value!},
                  readOnly: false,
                ),
                costumPadding.padding(15),
                CostomTextFormField(
                  label: "Panturrilha:",
                  iconTextField: Icons.numbers_outlined,
                  obscureText: false,
                  inputTextNumber: [
                    FilteringTextInputFormatter.digitsOnly,
                    CurrencyFormatter()
                  ],
                  onSaved: (value) => {calf1Right = value!},
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        SignupPupilAssessmentSixPage(
                                          pupilId: widget.pupilId,
                                          weight: widget.weight,
                                          hight: widget.hight,
                                          bmi: widget.bmi,
                                          subscapularis: widget.subscapularis,
                                          bicipital: widget.bicipital,
                                          thickness: widget.thickness,
                                          midaxillary: widget.midaxillary,
                                          suprailiac: widget.suprailiac,
                                          breastplate: widget.breastplate,
                                          abdominal: widget.abdominal,
                                          thigh: widget.thigh,
                                          calf: widget.calf,
                                          fatIdeal: widget.fatIdeal,
                                          currentFat: widget.currentFat,
                                          fatMass: widget.fatMass,
                                          leanMass: widget.leanMass,
                                          relationEntreWaistAndHip:
                                              widget.relationEntreWaistAndHip,
                                          token: widget.token,
                                        )));
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
