import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test_scheduler/blogic/requests/globalUrl.dart';
import 'package:http/http.dart' as http;

class ScheduleCorrectnessWidget extends StatefulWidget {
  @override
  _ScheduleCorrectnessWidgetState createState() => _ScheduleCorrectnessWidgetState();
}

class _ScheduleCorrectnessWidgetState extends State<ScheduleCorrectnessWidget> {
  late List<String> correctnessList = []; // Initialize with an empty list

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('http://${globalUrl}api/correctnessSchedule/checkCorrectness'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
      setState(() {
        correctnessList = List<String>.from(data);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Правильность расписания'),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black54,
          ),
        ),
      ),
      body: correctnessList.isEmpty // Check if the list is empty before building
          ? Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: correctnessList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              correctnessList[index],
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          );
        },
      ),
    );
  }
}
