import '../interfaces/entities/ITeacher.dart';

class Teacher implements ITeacher{
  @override
  final int teacherId;

  @override
  final String teacherName;

  @override
  final String teacherSurname;

  @override
  final String teacherPatronymic;

  Teacher({
    required this.teacherId,
    required this.teacherName,
    required this.teacherSurname,
    required this.teacherPatronymic
  });

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      teacherId: json['id'] as int,
      teacherName: json['teacherName'] as String,
      teacherSurname: json['teacherSurname'] as String,
      teacherPatronymic: json['teacherPatronymic'] as String,
    );
  }

}