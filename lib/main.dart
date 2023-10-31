import 'package:flutter/material.dart';
import 'package:flutter_test_scheduler/View/State/ScheduleTimeModel.dart';
import 'package:flutter_test_scheduler/View/Widgets/MyHomePage.dart';
import 'package:flutter_test_scheduler/View/Widgets/SchedulePage.dart';
import 'package:flutter_test_scheduler/View/Widgets/ScheduleTeachers.dart';
import 'package:provider/provider.dart';
import 'View/State/MyDataModel.dart';
import 'View/Widgets/NavigationButtonsWidget.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => ScheduleTimeModel(),
      child: const MaterialApp(
        home: NavigationButtonsWidget(),
      )
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ScheduleTeachersPage(),
    );
  }
}
