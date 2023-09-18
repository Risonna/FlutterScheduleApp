import '../interfaces/entities/ICabinet.dart';

class Cabinet implements ICabinet{
  @override
  final int cabinetId;

  @override
  final String cabinetName;

  Cabinet({
    required this.cabinetId,
    required this.cabinetName
  });

  factory Cabinet.fromJson(Map<String, dynamic> json) {
    return Cabinet(
      cabinetId: json['id'] as int,
      cabinetName: json['cabinetName'] as String,
    );
  }

}