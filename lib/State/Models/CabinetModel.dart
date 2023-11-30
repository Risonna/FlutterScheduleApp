import 'package:flutter/cupertino.dart';
import 'package:flutter_test_scheduler/blogic/requests/requesters/CabinetRequester.dart';

import '../../../blogic/domain/entities/Cabinet.dart';

class CabinetModel with ChangeNotifier {
  String selectedCabinet = '2226';
  List<String> _cabinets = [];
  bool _isLoading = false;
  String? _error;

  List<String> get cabinets{
    return _cabinets;
  }
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchCabinets() async {
    _isLoading = true;
    notifyListeners();
    List<String> fetchedCabinets = [];

    try {
      final cabinetData = await CabinetRequester().requestCabinets();


      for (Cabinet cabinet in cabinetData) {
        fetchedCabinets.add(cabinet.cabinetName);
      }
      _cabinets = fetchedCabinets;
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void updateSelectedCabinet(String cabinet) {
    selectedCabinet = cabinet;
    notifyListeners();
  }
}
