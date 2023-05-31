import 'package:flutter/material.dart';

import '../../controlles/app_controller.dart';
import '../../entities/assessment_entity.dart';
import '../../util/dialog.util.dart';

class BodyCompositionPupilOnePage extends StatefulWidget {
  Assessment assessment;
  BodyCompositionPupilOnePage({Key? key, required this.assessment})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return BodyCompositionPupilOnePageState();
  }
}

class BodyCompositionPupilOnePageState
    extends State<BodyCompositionPupilOnePage> {
  Message message = Message();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Composição Corporal'),
          actions: [
            changeTheme(),
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
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
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              'Peso Atual: ${widget.assessment.currentWeight}'),
                          Text('Altura: ${widget.assessment.hight}'),
                        ],
                      ),
                    ),
                  ),
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
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              'Seu último traino: ${widget.assessment.subscapularis ?? "..."}'),
                          Text(
                              'Bicipital: ${widget.assessment.bicipital ?? "..."}'),
                          Text(
                              'Tricipital: ${widget.assessment.thickness ?? "..."}'),
                          Text(
                              'Axilar-média: ${widget.assessment.midaxillary ?? "..."}'),
                          Text(
                              'Supra-ilíaca: ${widget.assessment.suprailiac ?? "..."}'),
                          Text(
                              'Peitoral: ${widget.assessment.breastplate ?? "..."}'),
                          Text(
                              'Abdominal: ${widget.assessment.abdominal ?? "..."}'),
                          Text('Coxa: ${widget.assessment.thigh ?? "..."}'),
                          Text(
                              'Paturrilha: ${widget.assessment.calf ?? "..."}'),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(40, 0, 0, 0),
                    alignment: AlignmentDirectional.centerStart,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('POLLOCK - 7 DOBRAS'),
                    )),
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
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              '% Gordura ideal: ${widget.assessment.fatIdeal ?? "..."}'),
                          Text(
                              '% Gordura atual: ${widget.assessment.currentFat ?? "..."}'),
                          Text(
                              'Massa magra: ${widget.assessment.leanMass ?? "..."}'),
                          Text(
                              'Massa gorda: ${widget.assessment.fatMass ?? "..."}'),
                        ],
                      ),
                    ),
                  ),
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
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('IMC: ${widget.assessment.bmi ?? "..."}'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class changeTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Switch(
      value: AppController.instance.isDarkTheme,
      onChanged: (value) {
        AppController.instance.changeTheme();
      },
    );
  }
}
