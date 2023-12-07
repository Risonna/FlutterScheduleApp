import 'package:flutter/material.dart';
import 'package:flutter_test_scheduler/State/Models/AdminsTeachersModel.dart';
import 'package:flutter_test_scheduler/State/Models/AuthorizationModel.dart';
import 'package:flutter_test_scheduler/State/Models/CabinetModel.dart';
import 'package:flutter_test_scheduler/State/Models/GroupModel.dart';
import 'package:flutter_test_scheduler/State/Models/LessonModel.dart';
import 'package:flutter_test_scheduler/State/Models/ScheduleTimeModel.dart';
import 'package:flutter_test_scheduler/State/Models/WebSocketModel.dart';
import 'package:provider/provider.dart';
import 'State/Models/TeacherModel.dart';
import 'View/Widgets/NavigationButtonsWidget.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TeacherModel()),
        ChangeNotifierProvider(create: (context) => CabinetModel()),
        ChangeNotifierProvider(create: (context) => ScheduleTimeModel()),
        ChangeNotifierProvider(create: (context) => LessonModel()),
        ChangeNotifierProvider(create: (context) => AuthorizationModel()),
        ChangeNotifierProvider(create: (context) => AdminsTeachersModel()),
        ChangeNotifierProvider(create: (context) => GroupModel()),
        ChangeNotifierProvider(create: (context) => WebSocketModel()),
      ],
      child:  MaterialApp(
        home: NavigationButtonsWidget(),
    ),
  ),
  );
}
