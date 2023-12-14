import 'package:flutter/material.dart';
import 'package:flutter_test_scheduler/View/Widgets/LessonCount/LessonCountWidgetCabinet.dart';
import 'package:flutter_test_scheduler/View/Widgets/LessonCount/LessonCountWidgetGroups.dart';
import 'package:flutter_test_scheduler/View/Widgets/LessonCount/LessonCountWidgetTeachers.dart';

import 'Schedules/ScheduleCabinets.dart';
import 'Schedules/ScheduleTeachers.dart';
import 'Schedules/occupation/ScheduleNoLessonsCabinets.dart';
import 'Schedules/occupation/ScheduleNoLessonsGroups.dart';
import 'Schedules/occupation/ScheduleNoLessonsTeachers.dart';
import 'SelectEntityWidget.dart';

import '../Components/NavigationDrawer.dart' as navDrawer;

class NavigationButtonsWidget extends StatelessWidget {
  NavigationButtonsWidget({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Главное меню'),
        backgroundColor: Colors.deepOrange,
      ),
      drawer: const navDrawer.NavigationDrawer(),
      body: Row(
        children: [
          Expanded(
            flex: 2, // Adjust the flex value as needed
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Main Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton('Расписание преподавателей', Colors.deepOrange, () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ScheduleTeachersPage(),
                        ));
                      }),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton('Расписание аудиторий', Colors.deepOrange, () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ScheduleCabinetsPage(),
                        ));
                      }),
                    ],
                  ),

                  // Smaller Buttons
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton('Подсчёт', Colors.orange, () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EntitySelectionWidget(
                            buttons: [
                              ButtonInfo('Группа', Colors.deepOrange, () => LessonCountWidgetGroup()),
                              ButtonInfo('Преподаватель', Colors.deepOrange, () => LessonCountWidgetTeacher()),
                              ButtonInfo('Аудитория', Colors.deepOrange, () => LessonCountWidgetCabinet()),
                            ],
                          ),
                        ));
                      }),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton('Занятость', Colors.orange, () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EntitySelectionWidget(
                            buttons: [
                              ButtonInfo('Группа', Colors.deepOrange, () => ScheduleNoLessonsGroupPage()),
                              ButtonInfo('Преподаватель', Colors.deepOrange, () => ScheduleNoLessonsTeacherPage()),
                              ButtonInfo('Аудитория', Colors.deepOrange, () => ScheduleNoLessonsCabinetsPage()),
                            ],
                          ),
                        ));
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback? onPressed;

  const CustomButton(this.text, this.color, this.onPressed, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      height: 50,
      margin: const EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: color,
          minimumSize: const Size(200, 40),
        ),
        child: Text(text),
      ),
    );
  }
}
