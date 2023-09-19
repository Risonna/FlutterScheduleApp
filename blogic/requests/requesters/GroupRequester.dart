import '../../domain/entities/Group.dart';
import 'Requester.dart';

class GroupRequester extends Requester{
  GroupRequester();

  Future<List<Group>> requestGroups(String url) async{
    Requester requester = Requester();
    dynamic objects = await requester.requestObjects("get-all-groups");

    List<Group> groups = [];

    for (dynamic groupMap in objects) {
      Group group = Group.fromJson(groupMap);
      groups.add(group);
    }

    return groups;
  }

}