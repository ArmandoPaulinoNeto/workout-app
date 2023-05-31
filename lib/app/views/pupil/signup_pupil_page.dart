import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:workout_app/app/entities/pupil_entity.dart';
import 'package:workout_app/app/services/signup_service.dart';
import 'package:workout_app/app/util/dialog.util.dart';
import 'package:workout_app/app/views/home_person_page.dart';
import '../../component/costum_text_form_field.dart';
import 'package:string_validator/string_validator.dart' as string_validator;
import '../../services/pupil_service.dart';
import '../../util/convert-base64.dart';
import '../../util/costumPadding.dart';
import '../../util/edit_image.dart';

class SignupPupilPage extends StatefulWidget {
  String token;
  Future<Pupil>? pupil;
  String task;
  SignupPupilPage(
      {super.key, this.pupil, required this.task, required this.token});

  @override
  State<SignupPupilPage> createState() => _SignupPupilPageState();
}

class _SignupPupilPageState extends State<SignupPupilPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  TextEditingController goalController = TextEditingController();
  TextEditingController photoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  CostumPadding costumPadding = CostumPadding();
  Message inputDialog = Message();

  final _keyForm = GlobalKey<FormState>();
  late String title =
      widget.task == "signup" ? "Cadastrar Aluno" : "Atualizar Aluno";
  late String id;
  late String name;
  late String personFk;
  late String birthday;
  late String sex;
  final List<String> sexList = <String>["Masculino", "Feminino"];
  late String accessFk;
  late String goal;
  late String photo;
  late String email;
  late String password;
  late String profileFk;
  bool filePhoto = false;
  String? _selectedvalue = "";

  _SignupPupilPageState() {
    _selectedvalue = sexList[0];
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
          child: widget.task.contains("update")
              ? FutureBuilder<Pupil>(
                  future: widget.pupil,
                  builder: (context, AsyncSnapshot<Pupil> snapshot) {
                    if (snapshot.hasData) {
                      Pupil pupil = snapshot.data!;
                      id = pupil.id!;
                      goalController.text = pupil.goal!;
                      personFk = pupil.personFk!;
                      nameController.text = pupil.name!;
                      dateController.text = DateFormat("dd/MM/yyyy")
                          .format(DateTime.parse(pupil.birthday!));
                      _selectedvalue = pupil.sex!;
                      accessFk = pupil.accessFk!;
                      emailController.text = pupil.email!;
                      passwordController.text = "Senha cadastrada";
                      password = pupil.password!;
                      profileFk = pupil.profileFk!;
                      photoController.text = "Foto carregada.";
                      filePhoto = true;
                      photo = pupil.photo!;
                      return formSignupPupil(context);
                    } else {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(0, 200, 0, 0),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  })
              : formSignupPupil(context),
        ));
  }

  Form formSignupPupil(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: _keyForm,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            CostomTextFormField(
              label: "name:",
              inputController: nameController,
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
              inputController: goalController,
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
              inputController: photoController,
              label: filePhoto ? "Foto carregada." : "Escolher a foto:",
              iconTextField:
                  filePhoto ? Icons.image_rounded : Icons.attach_file,
              obscureText: false,
              validator: (value) {
                if (!filePhoto) {
                  return "O campo foto não pode ser vazio.";
                }
              },
              readOnly: false,
              onTap: selectPhoto,
            ),
            costumPadding.padding(15),
            CostomTextFormField(
              inputController: emailController,
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
              inputController: passwordController,
              label: "Senha:",
              iconTextField: Icons.lock,
              obscureText: false,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "O campo senha não pode ser vazio.";
                }
                if (value.length < 6) {
                  return "Escolha um senha com no minimo 6 dígitos.";
                }
              },
              onSaved: (value) => {
                password =
                    value!.contains("Senha cadastrada") ? password : value
              },
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
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 0, 100, 0)),
                          ),
                          onPressed: () {
                            widget.task.contains("signup")
                                ? onReset()
                                : Navigator.of(context).pop(true);
                          },
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
                            if (_keyForm.currentState!.validate()) {
                              _keyForm.currentState!.save();
                              String response = await saveAction();
                              if (!response.contains("falha") ||
                                  !response.contains("não autorizado")) {
                                onReset();
                                inputDialog.dialogBuilder(context, "Alerta",
                                    "Os dados do aluno foram salvos corretamente!");
                              } else {
                                inputDialog.dialogBuilder(context, "Alerta",
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
    );
  }

  Future<String> saveAction() async {
    if (widget.task.contains("signup")) {
      SignupService signupService = SignupService();
      return await signupService.createPupil(goal, name, birthday, sex, photo,
          email, password, "pupil", widget.token);
    } else {
      PupilService pupilService = PupilService();
      return await pupilService.updatePupil(id, goal, personFk, name, birthday,
          sex, accessFk, photo, email, password, profileFk, widget.token);
    }
  }

  void onReset() {
    setState(() {
      filePhoto = false;
      _selectedvalue = sexList[0];
      dateController.text = "";
    });

    _keyForm.currentState!.reset();
  }

  selectPhoto() async {
    final ImagePicker imagePicker = ImagePicker();
    try {
      XFile? xFile = await imagePicker.pickImage(source: ImageSource.gallery);
      if (xFile != null) {
        EditImage()
            .ReduceImageQualityAndSize(xFile.path)
            .then((value) => {photo = ConvertBase64().convertToBase64(value)});
        setState(() {
          filePhoto = true;
        });
      }
    } catch (e) {
      print(e);
    }
  }
}
