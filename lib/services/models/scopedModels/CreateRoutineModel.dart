
import 'package:flutter/material.dart';
import 'package:myapp/services/models/Routine.dart';
import 'package:myapp/services/models/Shot.dart';
import 'package:myapp/services/models/ShotLocation.dart';
import 'package:scoped_model/scoped_model.dart';

class CreateRoutineModel extends Model {
  final int _initialTimeout = 1;

  CreateRoutineModel(List<ShotLocation> shotLocations) {
    _shotLocations = shotLocations;
    _timeoutController =
        TextEditingController(text: _initialTimeout.toString());
  }

  List<ShotLocation> _shotLocations;
  List<ShotLocation> get shotLocations => _shotLocations;

  void initializeShotDialog() {
    _timeoutController.text = _initialTimeout.toString();
  }

  int selectedShotId;

  void setSelectedShot(int id) {
    selectedShotId = id;
    notifyListeners();
  }

  TextEditingController _timeoutController;
  TextEditingController get timeoutController => _timeoutController;

  List<Shot> _shots = List<Shot>();
  List<Shot> get shots => _shots;

  void addCurrentShot(int locationId) {
    Shot myShot = _shotLocations
        .firstWhere((element) => element.id == locationId)
        .shots
        .firstWhere((element) => element.id == selectedShotId);

    myShot.timeout = int.parse(_timeoutController.text);

    _shots.add(myShot);

    if (_scrollController.hasClients) {
      Future.delayed(Duration(milliseconds: 100), () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeOut,
        );
      });
    }

    notifyListeners();
  }

  Routine createRoutine() {
    return new Routine(routineDesc: shots);
  }

  ScrollController _scrollController = ScrollController();
  ScrollController get scrollController => _scrollController;

  static CreateRoutineModel of(BuildContext context,
          {bool rebuildOnChange = false}) =>
      ScopedModel.of<CreateRoutineModel>(context,
          rebuildOnChange: rebuildOnChange == null ? false : rebuildOnChange);
}
