import 'administrator_entity.dart';
import 'notice_entity.dart';

class LoadingData {
  final Administrator administrator;
  final Notice notice;
  final int? count;
  LoadingData({required this.administrator, required this.notice, this.count});

  factory LoadingData.fromJson(Map<String, dynamic> json) {
    return LoadingData(
        administrator: Administrator.fromJson(json['administrator']),
        notice: Notice.fromJson(json['notice']),
        count: json['count']);
  }
}
