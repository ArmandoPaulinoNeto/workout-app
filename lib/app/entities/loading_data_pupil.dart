import 'package:workout_app/app/entities/pupil_entity.dart';

class LoadingDataPupil {
  Pupil? pupil;

  LoadingDataPupil({this.pupil});

  LoadingDataPupil.fromJson(Map<String, dynamic> json) {
    pupil = Pupil.fromJson(json['pupil']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pupil'] = this.pupil;
    return data;
  }
}
