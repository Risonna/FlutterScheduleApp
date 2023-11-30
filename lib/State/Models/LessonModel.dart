import 'package:flutter/cupertino.dart';
import 'package:flutter_test_scheduler/blogic/domain/entities/Lesson.dart';
import 'package:flutter_test_scheduler/blogic/requests/requesters/LessonRequester.dart';

class LessonModel with ChangeNotifier {
  List<Lesson> _lessons = [];
  bool _isLoading = false;
  String? _error;

  List<Lesson> get lessons{
    return _lessons;
  }
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchLessons() async {
    _isLoading = true;
    notifyListeners();

    List<Lesson> fetchedLessons = [];

    try {
      final lessonData = await LessonRequester().requestLessons();
      // Transform data if necessary
      for (Lesson lesson in lessonData) {
        fetchedLessons.add(lesson);
      }
      _lessons = fetchedLessons;
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}