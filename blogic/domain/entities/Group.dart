import '../interfaces/entities/IGroup.dart';

class Group implements IGroup{
  @override
  final int groupId;

  @override
  final String groupName;


  Group({
    required this.groupId,
    required this.groupName
  });

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      groupId: json['id'] as int,
      groupName: json['groupName'] as String,
    );
  }

}