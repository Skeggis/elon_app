import 'package:flutter/material.dart';
import 'package:myapp/components/screens/ControllerScreen/ControllerScreen.dart';
import 'package:myapp/components/screens/CreateOrganizationScreen/CreateOrganizationScreen.dart';
import 'package:myapp/components/screens/CreateRoutineScreen/CreateRoutineScreen.dart';
import 'package:myapp/components/screens/HomeScreen/HomeScreen.dart';
import 'package:myapp/components/screens/LoginSignUpScreen/SignUpScreen.dart';
import 'package:myapp/components/screens/LoginSignupScreen/LoginScreen.dart';
import 'package:myapp/components/screens/ProgramScreen/ProgramScreenCreate.dart';
import 'package:myapp/components/screens/ProgramScreen/arguments/ProgramScreenArguments.dart';
import 'package:myapp/components/screens/ProgramsScreen/ProgramsScreen.dart';
import 'package:myapp/components/screens/ProgramScreen/ProgramScreen.dart';
import 'package:myapp/components/screens/CompeteScreen/CompeteScreen.dart';
import 'package:myapp/components/screens/OrganizationScreen/OrganizationScreen.dart';

import 'package:myapp/components/screens/CompeteScreen/components/PlayersModal/PlayersModal.dart';
import 'package:myapp/components/screens/CompeteScreen/components/PlayersModal/components/AddPlayerModal.dart';

import 'package:myapp/services/models/UIModel.dart';

import 'package:myapp/components/screens/CompeteScreen/components/PlayersModal/components/body.dart';
import 'package:myapp/components/screens/CompeteScreen/components/PlayersModal/components/SearchBar.dart';
import 'package:myapp/services/models/scopedModels/DeviceModel.dart';

import 'package:myapp/services/models/scopedModels/PlayersModel.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:myapp/services/models/Organization.dart';

import 'package:myapp/Root.dart';

Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  ProgramScreen.routeName: (BuildContext context) => new ProgramScreen(),
  ProgramsScreen.routeName: (BuildContext context) => new ProgramsScreen(),
  ControllerScreen.routeName: (BuildContext context) => new ControllerScreen(),
  CompeteScreen.routeName: (BuildContext context) => new CompeteScreen(),
  ProgramScreenCreate.routeName: (BuildContext context) =>
      new ProgramScreenCreate(),
  CreateRoutineScreen.routeName: (BuildContext context) =>
      new CreateRoutineScreen(),
  LoginScreen.routeName: (BuildContext context) => new LoginScreen(),
  SignUpScreen.routeName: (BuildContext context) => new SignUpScreen(),
  Root.routeName: (BuildContext context) => new Root(),
  CreateOrganizationScreen.routeName: (BuildContext context) =>
      new CreateOrganizationScreen(),
};

void login(BuildContext context) {
  Navigator.pushNamed(context, LoginScreen.routeName);
}

void signUp(BuildContext context) {
  Navigator.pushNamed(context, SignUpScreen.routeName);
}

void home(BuildContext context) {
  UIModel.of(context).changeRoute(HomeScreen.routeName);
}

void controller(BuildContext context) {
  Navigator.pushNamed(context, ControllerScreen.routeName);
}

void organization(context) {
  UIModel.of(context).changeRoute(OrganizationScreen.routeName);
}

void editOrganization(context, Organization organization) {
  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) =>
            CreateOrganizationScreen(organization: organization)),
  );
}

void createOrganization(context) =>
    Navigator.pushNamed(context, CreateOrganizationScreen.routeName);

void programs(context) {
  UIModel.of(context).changeRoute(ProgramsScreen.routeName);
}

Future createProgram(context) {
  DeviceModel.of(context).createProgram();
  return Navigator.pushNamed(context, ProgramScreenCreate.routeName);
}

Future editProgram(context) {
  DeviceModel.of(context).editProgram();
  return Navigator.pushNamed(context, ProgramScreenCreate.routeName);
}

Future viewProgram(context, ProgramScreenArguments args) {
  DeviceModel.of(context).viewProgram();
  return Navigator.pushNamed(context, ProgramScreen.routeName, arguments: args);
}

void compete(context) {
  UIModel.of(context).changeRoute(CompeteScreen.routeName);
}

Future<void> playersModal(context) async {
  // Navigator.of(context).push(new PlayersModal());
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: SearchBar(height: 50),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ScopedModel<PlayersModel>(
              model: PlayersModel(), child: PlayersModalBody()),
        ],
      ),
      actions: <Widget>[
        RaisedButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Done'),
        )
      ],
    ),
  );
}

void addPlayerModal(context) {
  Navigator.of(context).push(new AddPlayerModal());
}
