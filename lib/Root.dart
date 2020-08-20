import 'package:flutter/material.dart';
import 'package:myapp/components/screens/ProgramScreen/ProgramScreen.dart';
import 'package:myapp/components/screens/ProgramScreen/ProgramScreenCreate.dart';
import 'package:myapp/components/screens/ProgramsScreen/ProgramsScreen.dart';
import 'package:myapp/services/models/scopedModels/DeviceModel.dart';
import 'package:myapp/services/models/Program.dart';
import 'package:myapp/styles/theme.dart';
import 'package:myapp/components/AppDrawer/AppDrawer.dart';

import 'package:myapp/components/screens/ConnectElonScreen/ConnectElonScreen.dart';
import 'package:myapp/components/screens/HomeScreen/HomeScreen.dart';
import 'package:myapp/components/screens/ControllerScreen/ControllerScreen.dart';

import 'package:myapp/components/screens/CompeteScreen/CompeteScreen.dart';
import 'package:myapp/components/screens/OrganizationScreen/OrganizationScreen.dart';

import 'package:myapp/routes/Routes.dart';

import 'package:myapp/services/models/UIModel.dart';

import 'package:myapp/services/models/UserModel.dart';
import 'package:myapp/components/screens/LoginSignUpScreen/InitialScreen.dart';

import 'package:myapp/services/UsersPreferences.dart';

class Root extends StatelessWidget {
  static const String routeName = '/root';
  @override
  Widget build(BuildContext context) {
    // bool isLoggedIn = UserModel.of(context, rebuildOnChange: true).isLoggedIn;

    // if (!isLoggedIn) {
    //   return InitialScreen();
    // }

    String route = UIModel.of(context, rebuildOnChange: true).route;
    print("Rebuilding!: ${route}");
    Widget screen;
    Widget fab;
    String screenTitle = "Elon";
    if (route == Routes.initial) {
      return new InitialScreen();
    }
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
        screenTitle = 'Programs';
        fab = FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, ProgramScreenCreate.routeName);
          },
          child: Icon(Icons.add),
        );
        break;
      case Routes.compete:
        screen = new CompeteScreen();
        screenTitle = 'Compete';
        break;
      case Routes.organization:
        screen = new OrganizationScreen();
        screenTitle = 'Organization';

        break;
      default:
        screen = InitialScreen();
    }

    bool loading = UIModel.of(context, rebuildOnChange: true).loading;
    return FutureBuilder<bool>(
        future: UsersPreferences.isLoggedIn(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData && snapshot.data) {
            return Stack(children: [
              Scaffold(
                resizeToAvoidBottomInset: true,
                drawer: AppDrawer(),
                floatingActionButton: fab,
                appBar: AppBar(
                  backgroundColor: MyTheme.barBackgroundColor,
                  elevation: 0.0,
                  title: Text(screenTitle),
                ),
                backgroundColor: MyTheme.backgroundColor,
                body: screen,
              ),
              loading ? Center(child: CircularProgressIndicator()) : Container()
            ]);
          } else {
            return new InitialScreen();
          }
        });
  }
}
