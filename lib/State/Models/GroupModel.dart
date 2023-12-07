import 'package:flutter/cupertino.dart';
import 'package:flutter_test_scheduler/blogic/domain/entities/Group.dart';
import 'package:flutter_test_scheduler/blogic/requests/requesters/GroupRequester.dart';


class GroupModel with ChangeNotifier {
  String selectedGroup = 'МОА-195';
  List<String> _groups = [];
  bool _isLoading = false;
  String? _error;

  List<String> get groups{
    return _groups;
  }
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchGroups() async {
    _isLoading = true;
    notifyListeners();
    List<String> fetchedGroups = [];

    try {
      final groupData = await GroupRequester().requestGroups();


      for (Group group in groupData) {
        fetchedGroups.add(group.groupName);
      }
      _groups = fetchedGroups;
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void updateSelectedGroup(String group) {
    selectedGroup = group;
    notifyListeners();
  }
}
