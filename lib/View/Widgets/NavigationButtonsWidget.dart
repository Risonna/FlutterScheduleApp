import 'package:flutter/material.dart';

import '../../blogic/domain/entities/LessonTime.dart';
import 'Schedules/ScheduleCabinets.dart';
import 'Schedules/ScheduleNoLessons.dart';
import 'Schedules/ScheduleTeachers.dart';
import 'SelectEntityWidget.dart';
import 'TimePeriodSelectionWidget.dart';

class NavigationButtonsWidget extends StatelessWidget {
  const NavigationButtonsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Главное меню'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          // Main Buttons
          Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomButton('Расписание по группам', Colors.deepOrange, null),
            CustomButton('Расписание преподавателей', Colors.deepOrange, () {
              // Navigate to ScheduleTeachersPage
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ScheduleTeachersPage(),
              ));
            }),
          ],
        ),
         Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton('Расписание аудиторий', Colors.deepOrange, () {
              // Navigate to ScheduleTeachersPage
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ScheduleCabinetsPage(),
              ));
            }),
            const CustomButton('Расписание кафедр', Colors.deepOrange, null),
          ],
        ),

        // Smaller Buttons
        const SizedBox(height: 20),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton('Подсчёт', Colors.orange, null),

          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton('Check Lesson', Colors.orange, null),

            const CustomButton('Когда будет пара?', Colors.orange, null),
            CustomButton('Когда нет пар?', Colors.orange, () {
              // Navigate to ScheduleTeachersPage
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => EntitySelectionWidget(),
              ));
            }),
          ],
        ),
        ],
        ),
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
      margin: const EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, backgroundColor: color,
          minimumSize: const Size(150, 40),
        ),
        child: Text(text),
      ),
    );
  }
}