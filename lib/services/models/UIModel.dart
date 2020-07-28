import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:myapp/routes/Routes.dart';

class UIModel extends Model {
  String _route = Routes.home;
  String get route => _route;
  void changeRoute(String newRoute) {
    _route = newRoute;
    notifyListeners();
  }

  static UIModel of(BuildContext context, {bool rebuildOnChange = false}) =>
      ScopedModel.of<UIModel>(context,
          rebuildOnChange: rebuildOnChange == null ? false : rebuildOnChange);
}
