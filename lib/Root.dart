import 'package:flutter/material.dart';
import 'package:myapp/styles/theme.dart';
import 'package:myapp/components/AppDrawer/AppDrawer.dart';

import 'package:myapp/components/screens/ConnectElonScreen/ConnectElonScreen.dart';
import 'package:myapp/components/screens/HomeScreen/HomeScreen.dart';
import 'package:myapp/components/screens/ControllerScreen/ControllerScreen.dart';

import 'package:myapp/routes/Routes.dart';

import 'package:myapp/services/models/UIModel.dart';

class Root extends StatelessWidget {
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
      default:
        screen = Container();
        screenTitle = "Not Found";
    }
    return Scaffold(
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
