import 'package:flutter/material.dart';

import 'NavigationButtonsWidget.dart';
import 'Schedules/ScheduleNoLessons.dart';

class EntitySelectionWidget extends StatelessWidget {

  const EntitySelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select an Entity'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton('Group', Colors.deepOrange, null),
            CustomButton('Teacher', Colors.deepOrange,() {
              // Navigate to ScheduleTeachersPage
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ScheduleNoLessonsPage(),
              ));
            } ),
            CustomButton('Cabinet', Colors.deepOrange, null),
          ],
        ),
      ),
    );
  }
}
