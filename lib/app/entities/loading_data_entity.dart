import 'administrator_entity.dart';
import 'notice_entity.dart';

class LoadingData {
  final Administrator administrator;
  final int? nPupils;
  final int? nTeachers;
  final Notice? notice;
  LoadingData(
      {required this.administrator,
      required this.notice,
      this.nPupils,
      this.nTeachers});

  factory LoadingData.fromJson(Map<String, dynamic> json) {
    return LoadingData(
        administrator: Administrator.fromJson(json['administrator']),
        notice: Notice.fromJson(json['notice']),
        nPupils: json['nPupils'],
        nTeachers: json['nTeachers']);
  }
}
