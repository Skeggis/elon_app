import 'package:myapp/services/models/Shot.dart';

class Routine {
  int rounds;
  int timeout;
  List<Shot> routineDesc;
  int displayTimeout;

  Routine({this.rounds, this.timeout, this.routineDesc}) {
    displayTimeout = timeout;
  }

  void resetDisplay(){
    displayTimeout = timeout;
  }

  factory Routine.fromJson(dynamic json) {
    var routineDescJson = json['routineDesc'] as List;
    List<Shot> _routineDescs = routineDescJson
        .map((routineDesc) => Shot.fromJson(routineDesc))
        .toList();
    return Routine(
        rounds: json['rounds'] as int,
        timeout: json['timeout'] as int,
        routineDesc: _routineDescs);
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> desc = routineDesc != null
        ? routineDesc.map((d) => d.toJson()).toList()
        : null;

    return {'rounds': rounds, 'timeout': timeout, 'routineDesc': desc};
  }
}
