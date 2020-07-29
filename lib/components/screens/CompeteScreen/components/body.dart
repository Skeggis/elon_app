import 'package:flutter/material.dart';

import 'package:myapp/services/models/CompeteModel.dart';
import 'package:myapp/styles/theme.dart';

import 'package:myapp/services/helpers.dart';

import 'package:myapp/routes/router.dart' as router;

class CompeteScreenBody extends StatelessWidget {
  Widget button(bool clicked, String title, Function onPressed) {
    return MaterialButton(
        padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
        onPressed: onPressed,
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: MyTheme.primaryColor, width: 2)),
        color: clicked ? MyTheme.primaryColor : MyTheme.backgroundColor,
        textColor: MyTheme.onPrimaryColor,
        child: Text(title, style: TextStyle(fontSize: 20)));
  }

  Widget playerButton(BuildContext context, String title) {
    double borderRadius = 5;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [BoxShadow(blurRadius: 50, color: Colors.black)]),
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        width: 300,
        height: 70,
        decoration: BoxDecoration(
          color: MyTheme.backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Material(
          borderRadius: BorderRadius.circular(borderRadius),
          color: Colors.transparent,
          child: InkWell(
            highlightColor: Colors.transparent,
            onTap: () => router.playersModal(context),
            child: Center(
                child: Row(
              children: [
                SizedBox(width: 10),
                Icon(
                  Icons.account_circle,
                  size: 40,
                  color: MyTheme.onPrimaryColor,
                ),
                SizedBox(width: 10),
                Text(title,
                    style:
                        TextStyle(fontSize: 20, color: MyTheme.onPrimaryColor))
              ],
            )),
          ),
        ),
      ),
    );
  }

  Widget teamWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        playerButton(context, "Player 1"),
        SizedBox(height: 15),
        playerButton(context, "Player 2")
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    bool singles = CompeteModel.of(context, rebuildOnChange: true).singles;
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                button(singles, 'Singles',
                    () => CompeteModel.of(context).toggleSingles()),
                SizedBox(width: 50),
                button(!singles, 'Doubles',
                    () => CompeteModel.of(context).toggleSingles()),
              ],
            ),
            SizedBox(height: 50),
            Expanded(flex: 1, child: mainBody(context)),
          ],
        ),
        Align(alignment: Alignment(0.9, 0.9), child: circlePlayButton(context))
      ],
    );
  }

  Widget circlePlayButton(BuildContext context) {
    return MaterialButton(
      onPressed: () {},
      shape: CircleBorder(),
      color: MyTheme.secondaryColor,
      child: Icon(Icons.play_arrow, size: 45, color: MyTheme.onPrimaryColor),
      colorBrightness: Brightness.dark,
      padding: EdgeInsets.all(10),
      elevation: 25,
      highlightElevation: 12,
    );
  }

  Widget playButton(BuildContext context) {
    return Container(
      width: screenWidth(context) * 0.5,
      child: MaterialButton(
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Play",
              style: TextStyle(fontSize: 24),
            ),
            Icon(Icons.play_arrow, size: 30, color: MyTheme.onPrimaryColor)
          ],
        ),
        color: MyTheme.secondaryColor,
        padding: EdgeInsets.all(15),
        minWidth: screenWidth(context) * 0.7,
        shape: StadiumBorder(),
        colorBrightness: Brightness.dark,
        elevation: 25,
        highlightElevation: 12,
      ),
    );
  }

  Widget mainBody(BuildContext context) {
    bool singles = CompeteModel.of(context, rebuildOnChange: true).singles;
    return singles
        ? ListView(
            children: [
              SizedBox(height: 20),
              Column(
                children: [
                  playerButton(context, "Player 1"),
                ],
              ),
              SizedBox(height: 25),
              Center(
                child: Text("Vs.",
                    style:
                        TextStyle(fontSize: 25, color: MyTheme.onPrimaryColor)),
              ),
              SizedBox(height: 25),
              Column(
                children: [
                  playerButton(context, "Player 2"),
                ],
              ),
              SizedBox(height: 150),
            ],
          )
        : ListView(
            children: [
              teamWidget(context),
              SizedBox(height: 25),
              Center(
                child: Text("Vs.",
                    style:
                        TextStyle(fontSize: 25, color: MyTheme.onPrimaryColor)),
              ),
              SizedBox(height: 25),
              teamWidget(context),
              SizedBox(height: 150)
            ],
          );
  }
}
