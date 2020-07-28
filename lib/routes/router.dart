import 'package:flutter/material.dart';
import 'package:myapp/components/screens/ControllerScreen/ControllerScreen.dart';
import 'package:myapp/components/screens/ProgramsScreen/ProgramsScreen.dart';

void controller(BuildContext context) {
  Navigator.push(context,
      new MaterialPageRoute(builder: (context) => new ControllerScreen()));
}

void programs(context){
  Navigator.push(context, new MaterialPageRoute(builder: (context) => ProgramsScreen()));
}
