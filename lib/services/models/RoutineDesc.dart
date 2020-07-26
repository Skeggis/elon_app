import 'package:myapp/services/models/Shot.dart';

class RoutineDesc {
  int id;
  int timeout;
  Shot shot;

  RoutineDesc({
    this.id,
    this.timeout,
    this.shot,
  });

  factory RoutineDesc.fromJson(dynamic json) {
    Shot _shot = Shot.fromJson(json['shot']);
    return RoutineDesc(
      id: json['id'] as int,
      shot: _shot,
      timeout: json['timeout'],
    );
  }
}
