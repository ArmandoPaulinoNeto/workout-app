import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workout_app/app/entities/assessment_entity.dart';
import 'package:workout_app/app/util/dialog.util.dart';
import 'package:workout_app/app/views/home_person_page.dart';
import 'package:workout_app/app/views/pupil/signup_pupil_assessment_five_page.dart';
import '../../component/costum_text_form_field.dart';
import '../../util/costumPadding.dart';
import '../../util/currencyFormatter.dart';

class SignupPupilAssessmentFourPage extends StatefulWidget {
  String pupilId;
  int pupilAge;
  String pupilSex;
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
  String token;
  SignupPupilAssessmentFourPage(
      {super.key,
      required this.pupilId,
      required this.pupilAge,
      required this.pupilSex,
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
  State<SignupPupilAssessmentFourPage> createState() =>
      _SignupPupilAssessmentFourPageState();
}

class _SignupPupilAssessmentFourPageState
    extends State<SignupPupilAssessmentFourPage> {
  CostumPadding costumPadding = CostumPadding();
  Message inputDialog = Message();

  final _keyForm = GlobalKey<FormState>();
  late String title = "Perímetros";
  late String shoulder;
  late String neck;
  late String relaxedChest;
  late String stimulatedChest;
  late String abdomen;
  late String waist;
  late String hip;
  List<TextInputFormatter> inputTextNumber = [
    FilteringTextInputFormatter.digitsOnly,
    CurrencyFormatter()
  ];

  _SignupPupilAssessmentFourPageState() {}

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
                  label: "Ombro:",
                  iconTextField: Icons.numbers_outlined,
                  obscureText: false,
                  inputTextNumber: inputTextNumber,
                  onSaved: (value) => {shoulder = value!},
                  readOnly: false,
                ),
                costumPadding.padding(15),
                CostomTextFormField(
                  label: "Pescoço:",
                  iconTextField: Icons.numbers_outlined,
                  obscureText: false,
                  inputTextNumber: inputTextNumber,
                  onSaved: (value) => {neck = value!},
                  readOnly: false,
                ),
                costumPadding.padding(15),
                CostomTextFormField(
                  label: "Tórax Relaxado:",
                  iconTextField: Icons.numbers_outlined,
                  obscureText: false,
                  inputTextNumber: inputTextNumber,
                  onSaved: (value) => {relaxedChest = value!},
                  readOnly: false,
                ),
                costumPadding.padding(15),
                CostomTextFormField(
                  label: "Tórax Inispirado:",
                  iconTextField: Icons.numbers_outlined,
                  obscureText: false,
                  inputTextNumber: inputTextNumber,
                  onSaved: (value) => {stimulatedChest = value!},
                  readOnly: false,
                ),
                costumPadding.padding(15),
                CostomTextFormField(
                  label: "Abdome:",
                  iconTextField: Icons.numbers_outlined,
                  obscureText: false,
                  inputTextNumber: inputTextNumber,
                  onSaved: (value) => {abdomen = value!},
                  readOnly: false,
                ),
                costumPadding.padding(15),
                CostomTextFormField(
                  label: "Cintura:",
                  iconTextField: Icons.numbers_outlined,
                  obscureText: false,
                  inputTextNumber: inputTextNumber,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "O campo cintura não pode ficar vazio.";
                    }
                  },
                  onSaved: (value) => {waist = value!},
                  readOnly: false,
                ),
                costumPadding.padding(15),
                CostomTextFormField(
                  label: "Quadril:",
                  iconTextField: Icons.numbers_outlined,
                  obscureText: false,
                  inputTextNumber: inputTextNumber,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "O campo quadril não pode ficar vazio.";
                    }
                  },
                  onSaved: (value) => {hip = value!},
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
                              double w = double.parse(
                                  waist.replaceAll(RegExp(r','), '.'));
                              double h = double.parse(
                                  hip.replaceAll(RegExp(r','), '.'));
                              var relationEntreWaistAndHip = Assessment()
                                  .relationEntreWaistAndHip(
                                      w, h, widget.pupilSex, widget.pupilAge);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          SignupPupilAssessmentFivePage(
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
                                                relationEntreWaistAndHip,
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
