import 'package:flutter/material.dart';

import 'ScheduleTeachers.dart';

class NavigationButtonsWidget extends StatelessWidget {
  const NavigationButtonsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule Options'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          // Main Buttons
          Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomButton('Group Schedule', Colors.deepOrange, null),
            CustomButton('Teacher Schedule', Colors.deepOrange, () {
              // Navigate to ScheduleTeachersPage
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ScheduleTeachersPage(),
              ));
            }),
          ],
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton('Cabinet Schedule', Colors.deepOrange, null),
            CustomButton('Department Schedule', Colors.deepOrange, null),
          ],
        ),

        // Smaller Buttons
        const SizedBox(height: 20),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton('Count', Colors.orange, null),
            CustomButton('Is Free', Colors.orange, null),
            CustomButton('Is Busy', Colors.orange, null),
          ],
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton('Check Lesson', Colors.orange, null),
            CustomButton('Check When', Colors.orange, null),
            CustomButton('No Lesson', Colors.orange, null),
          ],
        ),
        ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback? onPressed;

  const CustomButton(this.text, this.color, this.onPressed, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, backgroundColor: color,
          minimumSize: const Size(150, 40),
        ),
        child: Text(text),
      ),
    );
  }
}