import '../interfaces/entities/ISubject.dart';

class Subject implements ISubject{
  @override
  final int subjectId;

  @override
  final String subjectName;


  Subject({
    required this.subjectId,
    required this.subjectName
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      subjectId: json['id'] as int,
      subjectName: json['subjectName'] as String,
    );
  }

}