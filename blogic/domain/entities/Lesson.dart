import '../interfaces/entities/ILesson.dart';
import '../../requests/interfaces/IRequester.dart';
import '../../requests/requesters/GroupRequester.dart';
import '../../requests/requesters/Requester.dart';
import '../../requests/requesters/SubjectRequester.dart';
import 'Group.dart';
import 'Subject.dart';

class Lesson implements ILesson{
  @override
  final String lessonTime;
  @override
  final String lessonDay;
  @override
  final String lessonWeek;
  @override
  final int cabinetId;
  @override
  final int teacherId;
  @override
  final int groupId;
  @override
  final int subjectId;
  @override
  final int id;

  String? subjectName;
  String? cabinetName;
  String? groupName;
  String? teacherName;


  Lesson({
    required this.lessonTime,
    required this.lessonDay,
    required this.lessonWeek,
    required this.groupId,
    required this.cabinetId,
    required this.subjectId,
    required this.teacherId,
    required this.id
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      groupId: json['groupId'] as int,
      cabinetId: json['cabinetId'] as int,
      subjectId: json['subjectId'] as int,
      teacherId: json['teacherId'] as int,
      id: json['id'] as int,
      lessonDay: json['lessonDay'] as String,
      lessonTime: json['lessonTime'] as String,
      lessonWeek: json['lessonWeek'] as String

    );
  }

}
