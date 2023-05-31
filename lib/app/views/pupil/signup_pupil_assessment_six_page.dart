import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workout_app/app/util/dialog.util.dart';
import 'package:workout_app/app/views/home_person_page.dart';
import 'package:workout_app/app/views/pupil/signup_pupil_assessment_seven_page.dart';
import '../../component/costum_text_form_field.dart';
import '../../util/costumPadding.dart';
import '../../util/currencyFormatter.dart';

class SignupPupilAssessmentSixPage extends StatefulWidget {
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
  SignupPupilAssessmentSixPage(
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
      required this.relationEntreWaistAndHip,
      required this.token});

  @override
  State<SignupPupilAssessmentSixPage> createState() =>
      _SignupPupilAssessmentSixPageState();
}

class _SignupPupilAssessmentSixPageState
    extends State<SignupPupilAssessmentSixPage> {
  CostumPadding costumPadding = CostumPadding();
  Message inputDialog = Message();
  final _keyForm = GlobalKey<FormState>();
  late String title = "Esquerda(à)";
  late String forearmLeft;
  late String relaxedArmLeft;
  late String contractedArmLeft;
  late String thighLeft;
  late String calfLeft;
  late String waistXhit;
  List<TextInputFormatter> inputTextNumber = [
    FilteringTextInputFormatter.digitsOnly,
    CurrencyFormatter()
  ];

  _SignupPupilAssessmentSixPageState() {}

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
                  onSaved: (value) => {forearmLeft = value!},
                  readOnly: false,
                ),
                costumPadding.padding(15),
                CostomTextFormField(
                  label: "Braço Relaxado:",
                  iconTextField: Icons.numbers_outlined,
                  obscureText: false,
                  inputTextNumber: inputTextNumber,
                  onSaved: (value) => {relaxedArmLeft = value!},
                  readOnly: false,
                ),
                costumPadding.padding(15),
                CostomTextFormField(
                  label: "Braço Contraído:",
                  iconTextField: Icons.numbers_outlined,
                  obscureText: false,
                  inputTextNumber: inputTextNumber,
                  onSaved: (value) => {contractedArmLeft = value!},
                  readOnly: false,
                ),
                costumPadding.padding(15),
                CostomTextFormField(
                  label: "Coxa:",
                  iconTextField: Icons.numbers_outlined,
                  obscureText: false,
                  inputTextNumber: inputTextNumber,
                  onSaved: (value) => {thighLeft = value!},
                  readOnly: false,
                ),
                costumPadding.padding(15),
                CostomTextFormField(
                  label: "Panturrilha:",
                  iconTextField: Icons.numbers_outlined,
                  obscureText: false,
                  inputTextNumber: inputTextNumber,
                  onSaved: (value) => {calfLeft = value!},
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
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child: Center(
                          child: Column(
                        children: [
                          Text('Relação Cintura X Quadril',
                              style: TextStyle(
                                fontFamily: AutofillHints.addressCity,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              )),
                          Text('${widget.relationEntreWaistAndHip}',
                              style: TextStyle(
                                  fontFamily: AutofillHints.fullStreetAddress,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 0, 100, 0)))
                        ],
                      )),
                    ),
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        SignupPupilAssessmentSevenPage(
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
