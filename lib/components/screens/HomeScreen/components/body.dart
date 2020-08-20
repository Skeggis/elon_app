import 'package:flutter/material.dart';
import 'package:myapp/styles/theme.dart';
import 'package:myapp/services/helpers.dart';
import 'package:myapp/components/Logo/Logo.dart';

import 'package:myapp/routes/router.dart' as router;

class HomeScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 15),
          Logo(),
          SizedBox(height: 25),
          HomeButtons(),
        ],
      ),
    );
  }
}

class GenericButtonConfig {
  Function onPressed;
  String title;
  GenericButtonConfig({this.onPressed, this.title});
}

class HomeButtons extends StatelessWidget {
  List<GenericButtonConfig> buttons = [
    GenericButtonConfig(
        title: "Controller",
        onPressed: (BuildContext context) => router.controller(context)),
    GenericButtonConfig(
        title: "Programs", onPressed: (context) => router.programs(context)),
    // GenericButtonConfig(
    //     title: "Compete", onPressed: (context) => router.compete(context)),
    GenericButtonConfig(title: "Stats", onPressed: () {})
  ];
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      MainButton(),
      SizedBox(height: 40),
      for (var config in buttons) ...[
        NormalButton(
            title: config.title, onClick: () => config.onPressed(context)),
        SizedBox(height: 20)
      ]
    ]);
  }
}

class MainButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {},
      child: Text(
        "Quick Play",
        style: TextStyle(fontSize: 24, color: Colors.black),
      ),
      color: Theme.of(context).accentColor,
      padding: EdgeInsets.all(15),
      minWidth: screenWidth(context) * 0.7,
      shape: StadiumBorder(),
      colorBrightness: Brightness.dark,
      elevation: 25,
      highlightElevation: 12,
    );
  }
}

class NormalButton extends StatelessWidget {
  String title;
  Function onClick;
  NormalButton({this.onClick, this.title});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: this.onClick,
      color: Theme.of(context).primaryColor,
      child: Text(this.title == null ? 'Click me!' : this.title,
          style: TextStyle(fontSize: 20)),
      colorBrightness: Brightness.dark,
      minWidth: screenWidth(context) * 0.55,
      padding: EdgeInsets.all(15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}
