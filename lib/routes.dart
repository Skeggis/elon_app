import 'package:flutter/widgets.dart';
import 'package:myapp/components/screens/ConnectElonScreen/ConnectElonScreen.dart';
import 'package:myapp/components/screens/ElonScreen/ElonScreen.dart';
import 'package:myapp/components/screens/HomeScreen/HomeScreen.dart';
import 'package:myapp/components/screens/ControllerScreen/ControllerScreen.dart';
import 'package:myapp/components/WithSideBar/WithSideBar.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/": (BuildContext context) => WithSideBar(child: HomeScreen()),
  "/controller": (BuildContext context) => ControllerScreen(),
  // "/elon": (BuildContext context) => ElonScreen(),
  "/BLE": (BuildContext context) => ConnectElonScreen(),
};
