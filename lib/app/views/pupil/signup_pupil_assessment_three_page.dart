import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workout_app/app/util/dialog.util.dart';
import 'package:workout_app/app/views/home_person_page.dart';
import 'package:workout_app/app/views/pupil/signup_pupil_assessment_fuor_page.dart';
import '../../component/costum_text_form_field.dart';
import '../../util/costumPadding.dart';
import '../../util/currencyFormatter.dart';

class SignupPupilAssessmentThreePage extends StatefulWidget {
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
  double currentFat;
  double fatMass;
  double leanMass;
  String token;
  SignupPupilAssessmentThreePage(
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
      required this.currentFat,
      required this.fatMass,
      required this.leanMass,
      required this.token});

  @override
  State<SignupPupilAssessmentThreePage> createState() =>
      _SignupPupilAssessmentThreePageState();
}

class _SignupPupilAssessmentThreePageState
    extends State<SignupPupilAssessmentThreePage> {
  CostumPadding costumPadding = CostumPadding();
  Message inputDialog = Message();

  final _keyForm = GlobalKey<FormState>();
  late String title = "POLLOCK - 7 Dobras";
  late String fatIdeal;
  late String name;
  late String currentFat;
  late String leanMass;
  late String fatMass;
  List<TextInputFormatter> inputTextNumber = [
    FilteringTextInputFormatter.digitsOnly,
    CurrencyFormatter()
  ];

  _SignupPupilAssessmentThreePageState() {}

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
                  label: "Gordura ideal:",
                  iconTextField: Icons.percent_outlined,
                  obscureText: false,
                  inputTextNumber: inputTextNumber,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "O campo gordura ideal não pode ser vazio.";
                    }
                  },
                  onSaved: (value) => {fatIdeal = value!},
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
                    child: Center(
                        child: Text('% Gordura atual: ${widget.currentFat}',
                            style: TextStyle(
                                fontFamily: AutofillHints.fullStreetAddress,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 0, 100, 0)))),
                  ),
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
                    child: Center(
                        child: Text('Massa Magra: ${widget.leanMass}',
                            style: TextStyle(
                                fontFamily: AutofillHints.fullStreetAddress,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 0, 100, 0)))),
                  ),
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
                    child: Center(
                        child: Text('Massa Gorda: ${widget.fatMass}',
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          SignupPupilAssessmentFourPage(
                                            pupilId: widget.pupilId,
                                            pupilAge: widget.pupilAge,
                                            pupilSex: widget.pupilSex,
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
                                            fatIdeal: fatIdeal,
                                            currentFat: widget.currentFat,
                                            fatMass: widget.fatMass,
                                            leanMass: widget.leanMass,
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
