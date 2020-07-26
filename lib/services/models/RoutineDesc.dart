
import 'package:myapp/services/models/Shot.dart';

class RoutineDesc {
  int timeout;
  Shot shot;

  RoutineDesc({
    this.timeout,
    this.shot
  });

  factory RoutineDesc.fromJson(dynamic json){
    Shot _shot = Shot.fromJson(json['shot']);
    return RoutineDesc(shot: _shot, timeout: json['timeout']);
  }
}