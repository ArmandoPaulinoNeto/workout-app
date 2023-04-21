import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:workout_app/app/services/signup_service.dart';
import 'package:workout_app/app/util/dialog.util.dart';
import 'package:workout_app/app/views/home_person_page.dart';
import '../../component/costum_text_form_field.dart';
import 'package:string_validator/string_validator.dart' as string_validator;
import '../../entities/pupil_entity.dart';
import '../../util/convert-base64.dart';
import '../../util/costumPadding.dart';

class SignupPupilPage extends StatefulWidget {
  String token;
  SignupPupilPage({super.key, required this.token});

  @override
  State<SignupPupilPage> createState() => _SignupPupilPageState();
}

class _SignupPupilPageState extends State<SignupPupilPage> {
  TextEditingController dateController = TextEditingController();
  TextEditingController inputPhoto = TextEditingController();
  CostumPadding costumPadding = CostumPadding();
  Message message = Message();

  final _keyForm = GlobalKey<FormState>();
  late String name;
  late String birthday;
  late String sex;
  final List<String> sexList = <String>["Masculino", "Feminino"];
  late String goal;
  late String photo;
  XFile? filePhoto;
  String? _selectedvalue = "";
  late String email;
  late String password;

  _SignupPupilPageState() {
    _selectedvalue = sexList[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Cadastrar Aluno'),
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
                    label: "name:",
                    iconTextField: Icons.abc,
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "O campo nome não pode ser vazio.";
                      }
                      if (value.length < 6) {
                        return "Verifique se o nome foi digitado corretamente.";
                      }
                    },
                    onSaved: (value) => {name = value!},
                    readOnly: false,
                  ),
                  costumPadding.padding(15),
                  CostomTextFormField(
                    label: "Data de Nascimento",
                    inputController: dateController,
                    iconTextField: Icons.calendar_today,
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "O campo data não pode ser vazio.";
                      }
                    },
                    onSaved: (value) => {birthday = value!},
                    readOnly: true,
                    onTap: () async {
                      DateTime? pikckerDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                      );
                      if (pikckerDate != null) {
                        dateController.text =
                            DateFormat("dd/MM/yyyy").format(pikckerDate);
                      } else {
                        dateController.text = "";
                      }
                    },
                  ),
                  costumPadding.padding(15),
                  DropdownButtonFormField(
                    value: _selectedvalue,
                    items: sexList
                        .map((e) => DropdownMenuItem(
                              child: Text(e),
                              value: e,
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedvalue = value as String;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "Sexo:",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      prefixIcon: _selectedvalue == "Masculino"
                          ? Icon(Icons.man)
                          : Icon(Icons.woman_2_outlined),
                    ),
                    onSaved: (value) {
                      sex = value!;
                    },
                  ),
                  costumPadding.padding(15),
                  CostomTextFormField(
                    label: "Objetivo:",
                    iconTextField: Icons.gamepad,
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "O campo objetivo não pode ser vazio.";
                      }
                      if (value.length < 6) {
                        return "Verifique se o obletivo foi digitado corretamente.";
                      }
                    },
                    onSaved: (value) => {goal = value!},
                    readOnly: false,
                  ),
                  costumPadding.padding(15),
                  CostomTextFormField(
                    label: filePhoto == null ? "Foto:" : "Foto carregada.",
                    iconTextField: filePhoto == null
                        ? Icons.attach_file
                        : Icons.image_rounded,
                    obscureText: false,
                    validator: (value) {
                      if (filePhoto == null) {
                        return "O campo foto não pode ser vazio.";
                      }
                    },
                    onSaved: (value) {
                      ConvertBase64 convertToBase64 = ConvertBase64();
                      photo = convertToBase64.convertToBase64(filePhoto!.path);
                    },
                    readOnly: false,
                    onTap: selectPhoto,
                  ),
                  costumPadding.padding(15),
                  CostomTextFormField(
                    label: "Email:",
                    iconTextField: Icons.mail,
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "O campo email não pode ser vazio.";
                      }
                      if (!string_validator.isEmail(value)) {
                        return "Verifique se email foi digitado corretamente.";
                      }
                    },
                    onSaved: (value) => {email = value!},
                    readOnly: false,
                  ),
                  costumPadding.padding(15),
                  CostomTextFormField(
                    label: "Senha:",
                    iconTextField: Icons.lock,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "O campo senha não pode ser vazio.";
                      }
                      if (value.length < 6) {
                        return "Escolha um senha com no minimo 6 dígitos.";
                      }
                    },
                    onSaved: (value) => {password = value!},
                    readOnly: false,
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
                                onPressed: () {
                                  onReset();
                                },
                                label: Text("Cancelar"),
                                icon: Icon(Icons.cancel_outlined)),
                          ),
                          Container(
                            child: ElevatedButton.icon(
                                onPressed: () async {
                                  if (_keyForm.currentState!.validate()) {
                                    _keyForm.currentState!.save();
                                    SignupService signupService =
                                        SignupService();
                                    Pupil pupil =
                                        await signupService.createPupil(
                                            goal,
                                            name,
                                            birthday,
                                            sex,
                                            photo,
                                            email,
                                            password,
                                            "pupil",
                                            widget.token);
                                    if (pupil.id != null && pupil.id != "") {
                                      onReset();
                                      message.dialogBuilder(context, "Alerta",
                                          "Os dados do aluno foram salvos corretamente!");
                                    } else {
                                      message.dialogBuilder(context, "Alerta",
                                          "Erro ao salvar os dados do aluno!");
                                    }
                                  }
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
          ),
        ));
  }

  void onReset() {
    setState(() {
      filePhoto = null;
      dateController.text = "";
    });

    _keyForm.currentState!.reset();
  }

  selectPhoto() async {
    final ImagePicker imagePicker = ImagePicker();
    try {
      XFile? xFile = await imagePicker.pickImage(source: ImageSource.gallery);
      if (xFile != null) {
        setState(() {
          filePhoto = xFile;
        });
      }
    } catch (e) {
      print(e);
    }
  }
}
