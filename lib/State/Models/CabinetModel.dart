import 'package:flutter/cupertino.dart';
import 'package:flutter_test_scheduler/blogic/requests/requesters/CabinetRequester.dart';

import '../../../blogic/domain/entities/Cabinet.dart';

class CabinetModel with ChangeNotifier {
  String selectedCabinet = '2226';
  List<String> _cabinets = [];
  bool _isLoading = false;
  String? _error;

  List<String> get cabinets{
    if(_cabinets.isEmpty){
      fetchCabinets();
    }
    return _cabinets;
  }
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchCabinets() async {
    _isLoading = true;
    notifyListeners();

    try {
      final cabinetData = await CabinetRequester().requestCabinets();


      for (Cabinet cabinet in cabinetData) {
        _cabinets.add(cabinet.cabinetName);
      }
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
