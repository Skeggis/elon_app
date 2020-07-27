import 'package:flutter/material.dart';
import 'package:myapp/components/screens/ControllerScreen/ControllerScreen.dart';

void controller(BuildContext context) {
  Navigator.push(context,
      new MaterialPageRoute(builder: (context) => new ControllerScreen()));
}
