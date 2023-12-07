import 'package:flutter/material.dart';
import 'package:flutter_test_scheduler/State/Models/LessonModel.dart';
import 'package:flutter_test_scheduler/State/Models/ScheduleTimeModel.dart';
import 'package:flutter_test_scheduler/blogic/domain/entities/LessonTime.dart';
import 'package:provider/provider.dart';

import '../../../../State/Models/GroupModel.dart';
import '../../../../blogic/domain/sorterers/Sorterer.dart';


class ScheduleNoLessonsGroupPage extends StatefulWidget {
  ScheduleNoLessonsGroupPage({Key? key}) : super(key: key);

  @override
  State<ScheduleNoLessonsGroupPage> createState() => _ScheduleNoLessonsState();
}

class _ScheduleNoLessonsState extends State<ScheduleNoLessonsGroupPage> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if(Provider.of<GroupModel>(context, listen: false).groups.isEmpty) {
        Provider.of<GroupModel>(context, listen: false).fetchGroups();
      }
      if(Provider.of<LessonModel>(context, listen: false).lessons.isEmpty) {
        Provider.of<LessonModel>(context, listen: false).fetchLessons();
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    final lessonTime = Provider.of<ScheduleTimeModel>(context);
    final groupModel = Provider.of<GroupModel>(context);
    final lessonModel = Provider.of<LessonModel>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Расписание преподавателей'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16.0),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                borderRadius: BorderRadius.circular(16.0),
              ),
              margin: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
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
                          style: TextStyle(color: Colors.deepOrange.shade900, fontSize: 14),
                        ),
                      );
                    }).toList(),
                  ),
                  DropdownButton(
                    value: groupModel.selectedGroup,
                    onChanged: (String? newValue) {
                      groupModel.updateSelectedGroup(newValue!);
                    },
                    items: groupModel.groups.map((group) {
                      return DropdownMenuItem(
                        value: group,
                        child: Text(
                          group,
                          style: TextStyle(color: Colors.deepOrange.shade900, fontSize: 14),
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
                width: 1000,
                child: Card(
                  elevation: 8,
                  margin: const EdgeInsets.all(16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Column(
                    children: LessonTime.daysOfWeek.map((day) {
                      return Column(
                        children: [
                          // Day Header
                          Container(
                            padding: const EdgeInsets.all(16.0),
                            color: Colors.orange.shade200,
                            child: Text(
                              day,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          // Table of time periods and lessons
                          Table(
                            border: TableBorder.all(
                              color: Colors.orange.shade500,
                            ),
                            children: [
                              for (final timePeriod in LessonTime.timePeriods)
                                TableRow(
                                  children: [
                                    TableCell(
                                      child: Container(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          timePeriod,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.orange.shade900,
                                          ),
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: Container(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: Sorterer().getLessonsForTime(
                                            Sorterer().getLessonsForEntity(
                                              groupModel.selectedGroup,
                                              lessonModel.lessons,
                                            ),
                                            LessonTime(
                                              lessonDay: day,
                                              lessonTime: timePeriod,
                                              lessonWeek: lessonTime.selectedWeek,
                                            ),
                                          ).map(
                                                (lesson) {
                                              return Container(
                                                color: Colors.red,
                                                width: 1000,
                                                height: 25,
                                              );
                                            },
                                          ).toList(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ],
                      );
                    }).toList(),
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