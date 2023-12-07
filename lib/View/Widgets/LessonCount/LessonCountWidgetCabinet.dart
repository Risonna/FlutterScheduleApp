import 'package:flutter/material.dart';
import 'package:flutter_test_scheduler/State/Models/CabinetModel.dart';
import 'package:provider/provider.dart';
import '../../../State/Models/LessonModel.dart';
import '../../../blogic/domain/sorterers/Sorterer.dart';

class LessonCountWidgetCabinet extends StatefulWidget {
  LessonCountWidgetCabinet({Key? key}) : super(key: key);

  @override
  State<LessonCountWidgetCabinet> createState() => _LessonCountWidgetCabinetState();
}

class _LessonCountWidgetCabinetState extends State<LessonCountWidgetCabinet> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if(Provider.of<CabinetModel>(context, listen: false).cabinets.isEmpty) {
        Provider.of<CabinetModel>(context, listen: false).fetchCabinets();
      }
      if(Provider.of<LessonModel>(context, listen: false).lessons.isEmpty) {
        Provider.of<LessonModel>(context, listen: false).fetchLessons();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final cabinetModel = Provider.of<CabinetModel>(context);
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
                value: cabinetModel.selectedCabinet,
                items: cabinetModel.cabinets.map((String cabinet) {
                  return DropdownMenuItem<String>(
                    value: cabinet,
                    child: Text(
                      cabinet,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    cabinetModel.updateSelectedCabinet(newValue);
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
              'Количество занятий у ${cabinetModel.selectedCabinet}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              '${sorter.countLessons(cabinetModel.selectedCabinet, lessonModel.lessons)}',
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
