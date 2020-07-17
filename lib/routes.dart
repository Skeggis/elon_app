import 'package:flutter/widgets.dart';
import 'package:myapp/components/screens/ConnectElonScreen/ConnectElonScreen.dart';
import 'package:myapp/components/screens/ElonScreen/ElonScreen.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/": (BuildContext context) => ConnectElonScreen(),
  "/elon": (BuildContext context) => ElonScreen(),
};
