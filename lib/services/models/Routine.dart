import 'package:myapp/services/models/RoutineDesc.dart';

class Routine {
  int id;
  int rounds;
  int timeout;
  List<RoutineDesc> routineDescs;

  Routine({
    this.id,
    this.rounds,
    this.timeout,
    this.routineDescs
  });

  factory Routine.fromJson(dynamic json){
    var routineDescJson = json['routineDesc'] as List;
    List<RoutineDesc> _routineDescs = routineDescJson.map((routineDesc) => RoutineDesc.fromJson(routineDesc)).toList();
    return Routine(
      id: json['id'] as int,
      rounds: json['rounds'] as int,
      timeout: json['timeout'] as int,
      routineDescs: _routineDescs
    );
  }


}