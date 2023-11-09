import 'package:flutter/material.dart';
import 'package:flutter_test_scheduler/State/Models/ScheduleTimeModel.dart';
import 'package:flutter_test_scheduler/blogic/domain/entities/LessonTime.dart';
import 'package:provider/provider.dart';

import '../../../blogic/domain/sorterers/Sorterer.dart';
import '../../../State/Models/CabinetModel.dart';
import '../../../State/Models/LessonModel.dart';

class ScheduleCabinetsPage extends StatefulWidget {
  const ScheduleCabinetsPage({Key? key}) : super(key: key);

  @override
  State<ScheduleCabinetsPage> createState() => _ScheduleCabinetsPageState();
}

class _ScheduleCabinetsPageState extends State<ScheduleCabinetsPage> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final lessonTime = Provider.of<ScheduleTimeModel>(context);
    final cabinetModel = Provider.of<CabinetModel>(context);
    final lessonModel = Provider.of<LessonModel>(context);

    return Scaffold(
      backgroundColor: Colors.white, // Use a white background
      appBar: AppBar(
        title: const Text('Расписание аудиторий'), // Update the title
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
                    value: cabinetModel.selectedCabinet,
                    onChanged: (String? newValue) {
                      setState(() {
                        cabinetModel.updateSelectedCabinet(newValue!);
                      });
                    },
                    items: cabinetModel.cabinets.map((cabinet) {
                      return DropdownMenuItem(
                        value: cabinet,
                        child: Text(
                          cabinet,
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
                            child: Column(
                              children: Sorterer().getLessonsForTime(
                                Sorterer().getLessonsForEntity(cabinetModel.selectedCabinet, lessonModel.lessons),
                                time,
                              ).map((lesson) {
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
