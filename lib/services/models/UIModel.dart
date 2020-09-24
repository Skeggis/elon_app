import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:myapp/routes/Routes.dart';

class UIModel extends Model {
  bool _loading = false;
  bool get loading => _loading;

  void setLoading(bool isLoading) {
    _loading = isLoading;
    notifyListeners();
  }

  String _route = Routes.programs;
  String get route => _route;
  void changeRoute(String newRoute) {
    _route = newRoute;
    notifyListeners();
  }

  static UIModel of(BuildContext context, {bool rebuildOnChange = false}) =>
      ScopedModel.of<UIModel>(context,
          rebuildOnChange: rebuildOnChange == null ? false : rebuildOnChange);
}
