import 'package:flutter/material.dart';
import 'package:myapp/components/screens/ProgramScreen/ProgramScreen.dart';
import 'package:myapp/components/screens/ProgramsScreen/ProgramsScreen.dart';
import 'package:myapp/styles/theme.dart';
import 'package:myapp/components/AppDrawer/AppDrawer.dart';

import 'package:myapp/components/screens/ConnectElonScreen/ConnectElonScreen.dart';
import 'package:myapp/components/screens/HomeScreen/HomeScreen.dart';
import 'package:myapp/components/screens/ControllerScreen/ControllerScreen.dart';

import 'package:myapp/components/screens/CompeteScreen/CompeteScreen.dart';

import 'package:myapp/routes/Routes.dart';

import 'package:myapp/services/models/UIModel.dart';

class Root extends StatelessWidget {
  static const String routeName = '/';
  @override
  Widget build(BuildContext context) {
    String route = UIModel.of(context, rebuildOnChange: true).route;
    Widget screen;
    String screenTitle = "Elon";
    switch (route) {
      case Routes.home:
        screen = HomeScreen();
        screenTitle = "Elon";
        break;
      case Routes.bluetoothConnect:
        screen = ConnectElonScreen();
        screenTitle = "Connect";
        break;
      case Routes.programs:
        screen = ProgramsScreen();
        break;
      case Routes.program:
        screen = ProgramScreen();
        break;
      case Routes.compete:
        screen = new CompeteScreen();
        screenTitle = 'Compete';
        break;
      default:
        screen = Container();
        screenTitle = "Not Found";
    }
    return Scaffold(
      resizeToAvoidBottomInset: true,
      drawer: AppDrawer(),
      appBar: AppBar(
        backgroundColor: MyTheme.barBackgroundColor,
        elevation: 0.0,
        title: Text(screenTitle),
      ),
      body: screen,
    );
  }
}
