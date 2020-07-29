import 'package:flutter/material.dart';
import 'package:myapp/components/screens/ControllerScreen/ControllerScreen.dart';
import 'package:myapp/components/screens/ProgramsScreen/ProgramsScreen.dart';
import 'package:myapp/components/screens/ProgramScreen/ProgramScreen.dart';
import 'package:myapp/components/screens/CompeteScreen/CompeteScreen.dart';

import 'package:myapp/components/screens/CompeteScreen/components/PlayersModal/PlayersModal.dart';

import 'package:myapp/services/models/UIModel.dart';

Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  ProgramScreen.routeName: (BuildContext context) => new ProgramScreen(),
  ProgramsScreen.routeName: (BuildContext context) => new ProgramsScreen(),
  ControllerScreen.routeName: (BuildContext context) => new ControllerScreen(),
  CompeteScreen.routeName: (BuildContext context) => new CompeteScreen(),
};

void controller(BuildContext context) {
  Navigator.pushNamed(context, ControllerScreen.routeName);
}

void programs(context) {
  Navigator.pushNamed(context, ProgramsScreen.routeName);
}

void compete(context) {
  UIModel.of(context).changeRoute(CompeteScreen.routeName);
}

void playersModal(context) {
  Navigator.of(context).push(new PlayersModal());
}
