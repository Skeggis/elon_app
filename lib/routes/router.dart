import 'package:flutter/material.dart';
import 'package:myapp/components/screens/ControllerScreen/ControllerScreen.dart';
import 'package:myapp/components/screens/ProgramsScreen/ProgramsScreen.dart';
import 'package:myapp/components/screens/ProgramScreen/ProgramScreen.dart';

Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  ProgramScreen.routeName: (BuildContext context) => new ProgramScreen()
};

void controller(BuildContext context) {
  Navigator.push(context,
      new MaterialPageRoute(builder: (context) => new ControllerScreen()));
}

void programs(context) {
  Navigator.push(
      context, new MaterialPageRoute(builder: (context) => ProgramsScreen()));
}
