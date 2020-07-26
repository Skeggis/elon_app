import 'package:flutter/widgets.dart';
import 'package:myapp/components/screens/ConnectElonScreen/ConnectElonScreen.dart';
import 'package:myapp/components/screens/ElonScreen/ElonScreen.dart';
import 'package:myapp/components/screens/ProgramsScreen/ProgramsScreen.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  //"/": (BuildContext context) => ConnectElonScreen(),
  "/": (c) => ProgramsScreen(),
  //"/elon": (BuildContext context) => ElonScreen(),
};
