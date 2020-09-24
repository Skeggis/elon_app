import 'package:myapp/services/models/Shot.dart';
import 'package:myapp/services/models/ShotLocation.dart';
import 'package:myapp/services/models/ShotType.dart';

class CreateRoutineArguments {
  final List<ShotLocation> shotLocations;
  final List<Shot> shots;

  CreateRoutineArguments({this.shotLocations, this.shots});
}
