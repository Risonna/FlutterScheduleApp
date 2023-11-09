import 'package:flutter/material.dart';
import 'package:flutter_test_scheduler/blogic/domain/entities/LessonTime.dart';

class TimePeriodSelectionWidget extends StatefulWidget {
  final String entity;
  final Function(LessonTime) onTimePeriodSelected;

  const TimePeriodSelectionWidget({super.key,
    required this.entity,
    required this.onTimePeriodSelected,
  });

  @override
  _TimePeriodSelectionWidgetState createState() =>
      _TimePeriodSelectionWidgetState();
}

class _TimePeriodSelectionWidgetState extends State<TimePeriodSelectionWidget> {
  String selectedDay = LessonTime.daysOfWeek[0];
  String selectedTimePeriod = LessonTime.timePeriods[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Time Period for ${widget.entity}'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton(
              value: selectedDay,
              onChanged: (String? newValue) {
                setState(() {
                  selectedDay = newValue!;
                });
              },
              items: LessonTime.daysOfWeek.map((day) {
                return DropdownMenuItem(
                  value: day,
                  child: Text(day),
                );
              }).toList(),
            ),
            DropdownButton(
              value: selectedTimePeriod,
              onChanged: (String? newValue) {
                setState(() {
                  selectedTimePeriod = newValue!;
                });
              },
              items: LessonTime.timePeriods.map((time) {
                return DropdownMenuItem(
                  value: time,
                  child: Text(time),
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: () {
                final selectedLessonTime = LessonTime(
                  lessonDay: selectedDay,
                  lessonTime: selectedTimePeriod,
                  lessonWeek: "чет", // You can set this value as needed
                );
                widget.onTimePeriodSelected(selectedLessonTime);
                Navigator.of(context).pop(); // Close this widget
              },
              child: const Text('Search'),
            ),
          ],
        ),
      ),
    );
  }
}
