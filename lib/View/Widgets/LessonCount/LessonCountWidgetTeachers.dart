import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../State/Models/LessonModel.dart';
import '../../../State/Models/TeacherModel.dart';
import '../../../blogic/domain/sorterers/Sorterer.dart';

class LessonCountWidgetTeacher extends StatefulWidget {
  LessonCountWidgetTeacher({Key? key}) : super(key: key);

  @override
  State<LessonCountWidgetTeacher> createState() => _LessonCountWidgetTeacherState();
}

class _LessonCountWidgetTeacherState extends State<LessonCountWidgetTeacher> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if(Provider.of<TeacherModel>(context, listen: false).teachers.isEmpty) {
        Provider.of<TeacherModel>(context, listen: false).fetchTeachers();
      }
      if(Provider.of<LessonModel>(context, listen: false).lessons.isEmpty) {
        Provider.of<LessonModel>(context, listen: false).fetchLessons();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final teacherModel = Provider.of<TeacherModel>(context);
    final lessonModel = Provider.of<LessonModel>(context);
    Sorterer sorter = Sorterer();

    return Material(
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.indigo],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Theme(
              data: Theme.of(context).copyWith(
                canvasColor: Colors.deepPurple,
              ),
              child: DropdownButton<String>(
                value: teacherModel.selectedTeacher,
                items: teacherModel.teachers.map((String teacher) {
                  return DropdownMenuItem<String>(
                    value: teacher,
                    child: Text(
                      teacher,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    teacherModel.updateSelectedTeacher(newValue);
                  }
                },
                style: TextStyle(color: Colors.white),
                icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                elevation: 16,
                underline: Container(
                  height: 2,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Количество занятий у ${teacherModel.selectedTeacher}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              '${sorter.countLessons(teacherModel.selectedTeacher, lessonModel.lessons)}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
