import 'package:myapp/services/models/RoutineDesc.dart';

class Routine {
  int rounds;
  int timeout;
  List<RoutineDesc> routineDescs;

  Routine({
    this.rounds,
    this.timeout,
    this.routineDescs
  });

  factory Routine.fromJson(dynamic json){
    var routineDescJson = json['routineDesc'] as List;
    List<RoutineDesc> _routineDescs = routineDescJson.map((routineDesc) => RoutineDesc.fromJson(routineDesc)).toList();
    return Routine(
      rounds: json['rounds'] as int,
      timeout: json['timeout'] as int,
      routineDescs: _routineDescs
    );
  }


}