import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class UIModel extends Model {
  bool _isSideBarOpen = false;
  bool get isSideBarOpen => _isSideBarOpen;

  void toggleSideBarOpen() {
    _isSideBarOpen = !_isSideBarOpen;
    notifyListeners();
  }

  static UIModel of(BuildContext context, {bool rebuildOnChange = false}) =>
      ScopedModel.of<UIModel>(context,
          rebuildOnChange: rebuildOnChange == null ? false : rebuildOnChange);
}
