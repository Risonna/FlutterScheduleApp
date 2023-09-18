import '../../domain/entities/Subject.dart';
import 'Requester.dart';

class SubjectRequester extends Requester{
  SubjectRequester();

  Future<List<Subject>> requestSubjects(String url) async{
      Requester requester = Requester();
      dynamic objects = await requester.requestObjects("get-all-subjects");

      List<Subject> subjects = [];

      for (dynamic subjectMap in objects) {
        Subject subject = Subject.fromJson(subjectMap);
        subjects.add(subject);
      }

      return subjects;
  }

}