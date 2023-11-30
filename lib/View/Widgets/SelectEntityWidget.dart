import 'package:flutter/material.dart';

import 'NavigationButtonsWidget.dart';
import 'Schedules/ScheduleNoLessons.dart';

class EntitySelectionWidget extends StatelessWidget {

  const EntitySelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Страница выбора сущности'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton('Группа', Colors.deepOrange, null),
            CustomButton('Преподаватель', Colors.deepOrange,() {
              // Navigate to ScheduleTeachersPage
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ScheduleNoLessonsPage(),
              ));
            } ),
            CustomButton('Аудитория', Colors.deepOrange, null),
          ],
        ),
      ),
    );
  }
}
