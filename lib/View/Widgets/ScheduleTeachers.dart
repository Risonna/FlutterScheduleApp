import 'package:flutter/material.dart';
import 'package:flutter_test_scheduler/View/State/ScheduleTimeModel.dart';
import 'package:flutter_test_scheduler/blogic/domain/entities/LessonTime.dart';
import 'package:flutter_test_scheduler/blogic/requests/requesters/LessonRequester.dart';
import 'package:provider/provider.dart';

import '../../blogic/domain/entities/Lesson.dart';
import '../../blogic/domain/entities/Teacher.dart';
import '../../blogic/domain/sorterers/Sorterer.dart';
import '../../blogic/requests/requesters/TeacherRequester.dart';

class ScheduleTeachersPage extends StatefulWidget {
  const ScheduleTeachersPage({Key? key}) : super(key: key);

  @override
  _ScheduleTeachersPageState createState() => _ScheduleTeachersPageState();
}

class _ScheduleTeachersPageState extends State<ScheduleTeachersPage> {
  String selectedTeacher = 'Завозкин С.Ю.';
  List<String> teacherList = [];

  @override
  void initState() {
    super.initState();
    fetchTeacherList();
  }

  Future<void> fetchTeacherList() async {
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
      backgroundColor: Colors.white, // Use a white background
      appBar: AppBar(
        title: const Text('Class Schedule'), // Update the title
        backgroundColor: Colors.orangeAccent, // Change the app bar color
      ),
      body: SingleChildScrollView( // Scrollable content for smaller screens
        child: Column(
          children: [
            const SizedBox(height: 16.0),
            Container( // Use a container for better structure
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.orange.shade100, // Add a colored background
                borderRadius: BorderRadius.circular(16.0),
              ),
              margin: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Distribute items evenly
                children: [
                  DropdownButton(
                    value: lessonTime.selectedDay,
                    onChanged: (String? newValue) {
                      lessonTime.updateSelectedDay(newValue!);
                    },
                    items: LessonTime.daysOfWeek.map((day) {
                      return DropdownMenuItem(
                        value: day,
                        child: Text(
                          day,
                          style: TextStyle(color: Colors.deepOrange.shade900), // Change text color
                        ),
                      );
                    }).toList(),
                  ),
                  DropdownButton(
                    value: lessonTime.selectedWeek,
                    onChanged: (String? newValue) {
                      lessonTime.updateSelectedWeek(newValue!);
                    },
                    items: ScheduleTimeModel.lessonWeeksOddEven.map((week) {
                      return DropdownMenuItem(
                        value: week,
                        child: Text(
                          week,
                          style: TextStyle(color: Colors.deepOrange.shade900), // Change text color
                        ),
                      );
                    }).toList(),
                  ),
                  DropdownButton(
                    value: selectedTeacher,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedTeacher = newValue!;
                      });
                    },
                    items: teacherList.map((teacher) {
                      return DropdownMenuItem(
                        value: teacher,
                        child: Text(
                          teacher,
                          style: TextStyle(color: Colors.deepOrange.shade900), // Change text color
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
               width: 1000, // Set the desired width
                child: Card(
                elevation: 8,
                margin: const EdgeInsets.all(16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: ListView.builder(
                  itemCount: LessonTime.timePeriods.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(), // Use BouncingScrollPhysics for a bounce effect
                  itemBuilder: (context, timeIndex) {
                    final timePeriod = LessonTime.timePeriods[timeIndex];
                    final time = LessonTime(
                      lessonDay: lessonTime.selectedDay,
                      lessonTime: timePeriod,
                      lessonWeek: lessonTime.selectedWeek,
                    );

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 100,
                          height: 200,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.orange.shade500), // Update border color
                            borderRadius: BorderRadius.circular(16), // Increase border radius
                          ),
                          child: Center(
                            child: Text(
                              timePeriod,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.orange.shade900, // Change text color
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: FutureBuilder<List<Lesson>>(
                            future: LessonRequester().requestLessons(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (snapshot.hasError) {
                                return Text(
                                  'Error: ${snapshot.error}',
                                  style: const TextStyle(
                                    color: Colors.red,
                                  ),
                                );
                              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                return const Center(
                                  child: Text(
                                    'No lessons available for this time period',
                                    style: TextStyle(fontStyle: FontStyle.italic),
                                  ),
                                );
                              } else {
                                final lessons = Sorterer().getLessonsForTime(
                                  Sorterer().getLessonsForEntity(selectedTeacher, snapshot.data!),
                                  time,
                                );

                                return Column(
                                  children: lessons.map((lesson) {
                                    return Container(
                                      width: 500,
                                      height: 200,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.orange.shade600), // Update border color
                                        borderRadius: BorderRadius.circular(16), // Increase border radius
                                      ),
                                      child: Center(
                                        child: Text(
                                          "${lesson.lessonWeek} ${lesson.subjectName!} ${lesson.cabinetName!}",
                                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange.shade900),
                                        ),
                                      ),
                                    );
                                  }).toList(),
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
            ),
              ),
          ],
        ),
      ),
    );
  }
}
