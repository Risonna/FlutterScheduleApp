import 'package:flutter/material.dart';
import 'package:flutter_test_scheduler/View/State/ScheduleTimeModel.dart';
import 'package:flutter_test_scheduler/blogic/domain/entities/LessonTime.dart';
import 'package:flutter_test_scheduler/blogic/requests/requesters/LessonRequester.dart';
import 'package:provider/provider.dart';

import '../../blogic/domain/entities/Lesson.dart';
import '../../blogic/domain/entities/Teacher.dart';
import '../../blogic/domain/sorterers/Sorterer.dart';
import '../../blogic/requests/requesters/TeacherRequester.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  String selectedTeacher = 'Завозкин С.Ю.'; // Initial teacher, you can change this

  List<String> teacherList = []; // List to store teacher names

  @override
  void initState() {
    super.initState();
    // Fetch the list of teacher names when the widget is initialized
    fetchTeacherList();
  }

  Future<void> fetchTeacherList() async {
    // Fetch the list of teacher names
    final teachers = await TeacherRequester().requestTeachers("a");

    List<String> teacherNames = [];

    for (Teacher teacher in teachers) {
      if (teacher.teacherPatronymic != "unknown" && teacher.teacherSurname != "unknown") {
        teacherNames.add("${teacher.teacherSurname} ${teacher.teacherName.substring(0, 1)}.${teacher.teacherPatronymic.substring(0, 1)}.");
      } else {
        teacherNames.add(teacher.teacherName);
      }
    }

    setState(() {
      teacherList = teacherNames;
    });
  }

  @override
  Widget build(BuildContext context) {
    final lessonTime = Provider.of<ScheduleTimeModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule'),
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton(
                  value: lessonTime.selectedDay,
                  onChanged: (String? newValue) {
                    lessonTime.updateSelectedDay(newValue!);
                  },
                  items: LessonTime.daysOfWeek.map((day) {
                    return DropdownMenuItem(
                      value: day,
                      child: Text(day),
                    );
                  }).toList(),
                ),
                const SizedBox(width: 32.0),
                DropdownButton(
                  value: lessonTime.selectedWeek,
                  onChanged: (String? newValue) {
                    lessonTime.updateSelectedWeek(newValue!);
                  },
                  items: ScheduleTimeModel.lessonWeeksOddEven.map((week) {
                    return DropdownMenuItem(
                      value: week,
                      child: Text(week),
                    );
                  }).toList(),
                ),
                const SizedBox(width: 32.0),
                DropdownButton(
                  value: selectedTeacher, // Use the selected teacher
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedTeacher = newValue!;
                    });
                  },
                  items: teacherList.map((teacher) {
                    return DropdownMenuItem(
                      value: teacher,
                      child: Text(teacher), // Assuming TeacherRequester returns a list of teacher names
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: LessonTime.timePeriods.length,
                itemBuilder: (context, timeIndex) {
                  final timePeriod = LessonTime.timePeriods[timeIndex];
                  final time = LessonTime(
                    lessonDay: lessonTime.selectedDay,
                    lessonTime: timePeriod,
                    lessonWeek: lessonTime.selectedWeek,
                  );

                  return Row(
                    children: [
                      Container(
                        width: 100,
                        alignment: Alignment.center,
                        child: Text(timePeriod),
                      ),
                      Expanded(
                        child: FutureBuilder<List<Lesson>>(
                          future: LessonRequester().requestLessons(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return const Text('No lessons available for this time period');
                            } else {
                              final lessons = Sorterer().getLessonsForTime(
                                Sorterer().getLessonsForEntity(selectedTeacher, snapshot.data!), // Use the selected teacher
                                time, // Pass the LessonTime for the specific time period
                              );

                              return SizedBox( // Add a SizedBox to fix the size of the inner ListView
                                height: 200, // Set an appropriate height
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: lessons.length,
                                  itemBuilder: (context, lessonIndex) {
                                    final lesson = lessons[lessonIndex];
                                    return Container(
                                      width: 100,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                      ),
                                      child: Center(
                                        child: Text(lesson.subjectName!), // Replace with actual lesson data
                                      ),
                                    );
                                  },
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
