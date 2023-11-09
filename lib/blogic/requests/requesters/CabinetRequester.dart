import '../../domain/entities/Cabinet.dart';
import 'Requester.dart';

class CabinetRequester extends Requester{
  CabinetRequester();

  Future<List<Cabinet>> requestCabinets() async{
    Requester requester = Requester();
    dynamic objects = await requester.requestObjects("get-all-cabinets");

    List<Cabinet> cabinets = [];

    for (dynamic subjectMap in objects) {
      Cabinet cabinet = Cabinet.fromJson(subjectMap);
      cabinets.add(cabinet);
    }

    return cabinets;
  }

}