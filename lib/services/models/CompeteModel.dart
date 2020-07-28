import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CompeteModel extends Model {
  //Is the game singles or doubles?
  bool _singles = true;
  bool get singles => _singles;
  void toggleSingles() {
    _singles = !_singles;
    notifyListeners();
  }

  static CompeteModel of(BuildContext context,
          {bool rebuildOnChange = false}) =>
      ScopedModel.of<CompeteModel>(context,
          rebuildOnChange: rebuildOnChange == null ? false : rebuildOnChange);
}
