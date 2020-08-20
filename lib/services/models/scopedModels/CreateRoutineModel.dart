import 'package:flutter/material.dart';
import 'package:myapp/services/models/Routine.dart';
import 'package:myapp/services/models/Shot.dart';
import 'package:myapp/services/models/ShotLocation.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class CreateRoutineModel extends Model {
  final int _initialTimeout = 1;

  CreateRoutineModel(List<ShotLocation> shotLocations) {
    _shotLocations = shotLocations;
    currentShotTimeout = _initialTimeout;
  }

  List<ShotLocation> _shotLocations;
  List<ShotLocation> get shotLocations => _shotLocations;

  int selectedShotId;

  void setSelectedShot(int id) {
    selectedShotId = id;
    notifyListeners();
  }

  void initializeShotDialog() {
    // _currentShotTimeout = _initialTimeout;
  }

  int currentShotTimeout;

  void setCurrentShotTimeout(int timeout) {
    currentShotTimeout = timeout;
    notifyListeners();
  }

  List<Shot> _shots = List<Shot>();
  List<Shot> get shots => _shots;

  void addCurrentShot(int locationId) {
    print(locationId);
    print(selectedShotId);
    Shot myShot = _shotLocations
        .firstWhere((element) => element.id == locationId)
        .shots
        .firstWhere((element) => element.id == selectedShotId);

    myShot.timeout = currentShotTimeout;
    currentShotTimeout = _initialTimeout;

    _shots.add(myShot);

    if (_scrollController.isAttached) {
      Future.delayed(Duration(milliseconds: 100), () {
        _scrollController.scrollTo(
          index: shots.length -1,
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

  ItemScrollController _scrollController = ItemScrollController();
  ItemScrollController get scrollController => _scrollController;

  static CreateRoutineModel of(BuildContext context,
          {bool rebuildOnChange = false}) =>
      ScopedModel.of<CreateRoutineModel>(context,
          rebuildOnChange: rebuildOnChange == null ? false : rebuildOnChange);
}
