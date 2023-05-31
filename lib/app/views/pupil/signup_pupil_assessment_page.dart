import 'package:flutter/material.dart';
import 'package:workout_app/app/util/dialog.util.dart';
import 'package:workout_app/app/views/home_person_page.dart';
import 'package:workout_app/app/views/pupil/signup_pupil_assessment_one_page.dart';
import '../../component/costum_text_form_field.dart';
import '../../util/costumPadding.dart';

class SignupPupilAssessmentPage extends StatefulWidget {
  String pupilId;
  String pupilBirthday;
  String pupilSex;
  String token;
  SignupPupilAssessmentPage(
      {super.key,
      required this.pupilId,
      required this.pupilBirthday,
      required this.pupilSex,
      required this.token});

  @override
  State<SignupPupilAssessmentPage> createState() =>
      _SignupPupilAssessmentPageState();
}

class _SignupPupilAssessmentPageState extends State<SignupPupilAssessmentPage> {
  CostumPadding costumPadding = CostumPadding();
  Message inputDialog = Message();

  final _keyForm = GlobalKey<FormState>();
  late String title = "Anamnese";
  late String id;
  late String professionalActivity;
  late String activityPhysicalHistore;
  late String surgicalIntevention;
  late String eatingHabits;
  late String medicineUsed;
  late String cigarretteAlcohol;
  late String familyHistory;
  late String goal;
  late String availability;
  late String observations;
  late String posturalEvaluation;

  _SignupPupilAssessmentPageState() {}

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
                  label: "Atividade Profissional:",
                  iconTextField: Icons.work,
                  obscureText: false,
                  onSaved: (value) => {professionalActivity = value!},
                  readOnly: false,
                ),
                costumPadding.padding(15),
                CostomTextFormField(
                  label: "Historico de Atividade Física:",
                  iconTextField: Icons.abc,
                  obscureText: false,
                  onSaved: (value) => {activityPhysicalHistore = value!},
                  readOnly: false,
                ),
                costumPadding.padding(15),
                CostomTextFormField(
                  label: "Intervenção Cirúrgica:",
                  iconTextField: Icons.airline_seat_flat,
                  obscureText: false,
                  onSaved: (value) => {surgicalIntevention = value!},
                  readOnly: false,
                ),
                costumPadding.padding(15),
                CostomTextFormField(
                  label: "Hábitos Alimentares:",
                  iconTextField: Icons.dinner_dining,
                  obscureText: false,
                  onSaved: (value) => {eatingHabits = value!},
                  readOnly: false,
                ),
                costumPadding.padding(15),
                CostomTextFormField(
                  label: "Medicação em Uso:",
                  iconTextField: Icons.medication,
                  obscureText: false,
                  onSaved: (value) => {medicineUsed = value!},
                  readOnly: false,
                ),
                costumPadding.padding(15),
                CostomTextFormField(
                  label: "Tabegismo/Alcoolismos:",
                  iconTextField: Icons.smoking_rooms_outlined,
                  obscureText: false,
                  onSaved: (value) => {cigarretteAlcohol = value!},
                  readOnly: false,
                ),
                costumPadding.padding(15),
                CostomTextFormField(
                  label: "Antecedentes Familiares:",
                  iconTextField: Icons.family_restroom,
                  obscureText: false,
                  onSaved: (value) => {familyHistory = value!},
                  readOnly: false,
                ),
                costumPadding.padding(15),
                CostomTextFormField(
                  label: "Objetivo:",
                  iconTextField: Icons.playlist_add_circle,
                  obscureText: false,
                  onSaved: (value) => {goal = value!},
                  readOnly: false,
                ),
                costumPadding.padding(15),
                CostomTextFormField(
                  label: "Disponibilidade:",
                  iconTextField: Icons.event_available_outlined,
                  obscureText: false,
                  onSaved: (value) => {availability = value!},
                  readOnly: false,
                ),
                costumPadding.padding(15),
                CostomTextFormField(
                  label: "Observações:",
                  iconTextField: Icons.edit,
                  obscureText: false,
                  onSaved: (value) => {observations = value!},
                  readOnly: false,
                ),
                costumPadding.padding(15),
                CostomTextFormField(
                  label: "Av. Postural:",
                  iconTextField: Icons.lock,
                  obscureText: false,
                  onSaved: (value) => {posturalEvaluation = value!},
                  readOnly: false,
                ),
                SizedBox(
                  width: double.infinity,
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
                                          SignupPupilAssessmentOnePage(
                                            pupilId: widget.pupilId,
                                            pupilBirthday: widget.pupilBirthday,
                                            pupilSex: widget.pupilSex,
                                            token: widget.token,
                                          )));
                            }),
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
