import 'package:flutter/material.dart';
import 'package:workout_app/app/services/pupil_service.dart';
import 'package:workout_app/app/views/pupil/profile_pupil_page.dart';

import '../../controlles/app_controller.dart';
import '../../entities/assessment_entity.dart';
import '../../entities/person_logged.dart';
import '../../entities/pupil_entity.dart';
import '../../util/dialog.util.dart';
import '../home_pupil_page.dart';
import 'body_composition_pupil_page.dart';
import 'find_schedule_pupil_page.dart';

class PageviewPupil extends StatefulWidget {
  PersonLogged pupilLogged;
  PageviewPupil({Key? key, required this.pupilLogged}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PageviewPupilState();
  }
}

class PageviewPupilState extends State<PageviewPupil> {
  int currentPage = 0;
  late PageController pageController;
  Message message = Message();

  @override
  void initState() {
    pageController = PageController(initialPage: currentPage);
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: [
          HomePupilPage(token: widget.pupilLogged.token),
          BodyCompositionPupilPage(
            futureListAssessment:
                fetchAllAssessmentByPupilId(widget.pupilLogged.token),
            token: widget.pupilLogged.token,
          ),
          FindSchedulePupilPage(
            token: widget.pupilLogged.token,
          ),
          ProfilePupilPage(pupilLogged: widget.pupilLogged)
        ],
        onPageChanged: (page) {
          setState(() {
            currentPage = page;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color.fromARGB(255, 8, 125, 179),
        currentIndex: currentPage,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Color.fromARGB(255, 0, 100, 0),
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.contact_page_outlined,
                  color: Color.fromARGB(255, 0, 100, 0)),
              label: 'Avaliação'),
          BottomNavigationBarItem(
              icon: Icon(Icons.schedule_send_sharp,
                  color: Color.fromARGB(255, 0, 100, 0)),
              label: 'treinos'),
          BottomNavigationBarItem(
              icon: Icon(Icons.accessibility_new_sharp,
                  color: Color.fromARGB(255, 0, 100, 0)),
              label: 'Prefil'),
        ],
        onTap: (page) {
          pageController.animateToPage(page,
              duration: Duration(milliseconds: 400), curve: Curves.ease);
        },
      ),
    );
  }
}

Future<List<Assessment>> fetchAllAssessmentByPupilId(String token) {
  PupilService pupilService = PupilService();

  return pupilService.fetchAllAssessmentByPupilId(token);
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
