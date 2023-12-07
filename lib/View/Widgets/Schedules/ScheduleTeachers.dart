import 'package:flutter/material.dart';
import 'package:flutter_test_scheduler/State/Models/LessonModel.dart';
import 'package:flutter_test_scheduler/State/Models/ScheduleTimeModel.dart';
import 'package:flutter_test_scheduler/State/Models/TeacherModel.dart';
import 'package:flutter_test_scheduler/blogic/domain/entities/LessonTime.dart';
import 'package:provider/provider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../blogic/domain/sorterers/Sorterer.dart';

class ScheduleTeachersPage extends StatefulWidget {
  ScheduleTeachersPage({Key? key}) : super(key: key);

  @override
  State<ScheduleTeachersPage> createState() => _ScheduleTeachersPageState();
}

class _ScheduleTeachersPageState extends State<ScheduleTeachersPage> {

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
    final lessonTime = Provider.of<ScheduleTimeModel>(context);
    final teacherModel = Provider.of<TeacherModel>(context);
    final lessonModel = Provider.of<LessonModel>(context);
      return Scaffold(
        backgroundColor: Colors.white, // Use a white background
        appBar: AppBar(
          title: const Text('Расписание преподавателей'), // Update the title
          backgroundColor: Colors.orangeAccent, // Change the app bar color
        ),
        body: SingleChildScrollView( // Scrollable content for smaller screens
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  // Distribute items evenly
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
                            style: TextStyle(color: Colors.deepOrange
                                .shade900, fontSize: 14), // Change text color
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
                            style: TextStyle(color: Colors.deepOrange
                                .shade900, fontSize: 14), // Change text color
                          ),
                        );
                      }).toList(),
                    ),

                    DropdownButton(
                      value: teacherModel.selectedTeacher,
                      onChanged: (String? newValue) {
                        teacherModel.updateSelectedTeacher(newValue!);
                      },
                      items: teacherModel.teachers.map((teacher) {
                        return DropdownMenuItem(
                          value: teacher,
                          child: Text(
                            teacher,
                            style: TextStyle(color: Colors.deepOrange
                                .shade900, fontSize: 14), // Change text color
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
                      physics: const BouncingScrollPhysics(),
                      // Use BouncingScrollPhysics for a bounce effect
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
                                border: Border.all(
                                    color: Colors.orange.shade500),
                                // Update border color
                                borderRadius: BorderRadius.circular(
                                    16), // Increase border radius
                              ),
                              child: Center(
                                child: Text(
                                  timePeriod,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.orange
                                        .shade900, // Change text color
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                                child: Column(
                                  children: Sorterer().getLessonsForTime(
                                    Sorterer().getLessonsForEntity(
                                        teacherModel.selectedTeacher,
                                        lessonModel.lessons),
                                    time,
                                  ).map((lesson) {
                                    return Container(
                                      width: 500,
                                      height: 200,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.orange.shade600),
                                        // Update border color
                                        borderRadius: BorderRadius.circular(
                                            16), // Increase border radius
                                      ),
                                      child: Center(
                                        child: Text(
                                          "${lesson.lessonWeek} ${lesson
                                              .subjectName!} ${lesson
                                              .cabinetName!}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.orange.shade900),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                )
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
