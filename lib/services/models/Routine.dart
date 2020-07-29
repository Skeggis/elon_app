import 'package:myapp/services/models/Shot.dart';

class Routine {
  int rounds;
  int timeout;
  List<Shot> routineDesc;

  Routine({
    this.rounds,
    this.timeout,
    this.routineDesc
  });

  factory Routine.fromJson(dynamic json){
    var routineDescJson = json['routineDesc'] as List;
    List<Shot> _routineDescs = routineDescJson.map((routineDesc) => Shot.fromJson(routineDesc)).toList();
    return Routine(
      rounds: json['rounds'] as int,
      timeout: json['timeout'] as int,
      routineDesc: _routineDescs
    );
  }


}