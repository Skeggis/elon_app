import 'package:flutter/material.dart';
import 'package:myapp/components/screens/ControllerScreen/ControllerScreen.dart';
import 'package:myapp/components/screens/ProgramsScreen/ProgramsScreen.dart';
import 'package:myapp/components/screens/ProgramScreen/ProgramScreen.dart';

Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  ProgramScreen.routeName: (BuildContext context) => new ProgramScreen(),
  ProgramsScreen.routeName: (BuildContext context) => new ProgramsScreen(),
  ControllerScreen.routeName: (BuildContext context) => new ControllerScreen(),
};

void controller(BuildContext context) {
  Navigator.pushNamed(context, ControllerScreen.routeName);
}

void programs(context) {
  Navigator.pushNamed(context, ProgramsScreen.routeName);
}
