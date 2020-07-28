import 'package:flutter/widgets.dart';
import 'package:myapp/components/screens/ConnectElonScreen/ConnectElonScreen.dart';
import 'package:myapp/components/screens/ElonScreen/ElonScreen.dart';
import 'package:myapp/components/screens/ProgramScreen/ProgramScreen.dart';
import 'package:myapp/components/screens/ProgramsScreen/ProgramsScreen.dart';
import 'package:myapp/components/screens/HomeScreen/HomeScreen.dart';
import 'package:myapp/components/screens/ControllerScreen/ControllerScreen.dart';
import 'package:myapp/components/WithSideBar/WithSideBar.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  // "/": (BuildContext context) => WithSideBar(child: HomeScreen()),
  "/": (c) => ProgramsScreen(),
  ProgramScreen.routeName : (context) => ProgramScreen()
  //"/controller": (BuildContext context) => ControllerScreen(),
  // "/elon": (BuildContext context) => ElonScreen(),
  //"/BLE": (BuildContext context) => ConnectElonScreen(),

};
