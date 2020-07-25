import 'package:flutter/widgets.dart';
import 'package:myapp/components/screens/ConnectElonScreen/ConnectElonScreen.dart';
import 'package:myapp/components/screens/ElonScreen/ElonScreen.dart';
import 'package:myapp/components/screens/HomeScreen/HomeScreen.dart';
import 'package:myapp/components/screens/ControllerScreen/ControllerScreen.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => HomeScreen(),
  "/": (BuildContext context) => ControllerScreen(),
  // "/elon": (BuildContext context) => ElonScreen(),
  // "/ble": (BuildContext context) => ConnectElonScreen(),
};
