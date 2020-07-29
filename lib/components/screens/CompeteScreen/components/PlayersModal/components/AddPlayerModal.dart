import 'package:flutter/material.dart';
import 'package:myapp/services/helpers.dart';
import 'package:myapp/styles/theme.dart';

import 'package:myapp/services/models/PlayersModel.dart';

class AddPlayerModal extends ModalRoute<void> {
  @override
  Duration get transitionDuration => Duration(milliseconds: 500);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    // This makes sure that text and other content follows the material style
    return Material(
      type: MaterialType.transparency,
      child: SafeArea(
        child: _buildOverlayContent(context),
      ),
    );
  }

  Widget body(BuildContext context) {
    return Center(
        child: GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
          decoration: BoxDecoration(
              color: MyTheme.backgroundColor,
              borderRadius: BorderRadius.circular(10)),
          child: Stack(
            children: [
              Positioned(
                top: 15,
                left: 20,
                child: Text("Create a New Player",
                    style:
                        TextStyle(color: MyTheme.onPrimaryColor, fontSize: 22)),
              ),
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Container(
                      width: screenWidth(context) * 0.8,
                      child: TextField(
                        style: TextStyle(
                            color: MyTheme.onPrimaryColor, fontSize: 17),
                        cursorColor: MyTheme.onPrimaryColor.withOpacity(0.5),
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: MyTheme.onPrimaryColor
                                        .withOpacity(0.95))),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: MyTheme.onPrimaryColor
                                        .withOpacity(0.5))),
                            // focusedBorder: InputBorder.none,
                            alignLabelWithHint: true,
                            labelText: "name",
                            labelStyle: TextStyle(
                                fontSize: 17,
                                color:
                                    MyTheme.onPrimaryColor.withOpacity(0.5))),
                      ),
                    ),
                    Container(
                      child: DropdownButton<String>(
                        value: 'Organization',
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            // dropdownValue = newValue;
                          });
                        },
                        items: <String>['Organization', 'Two', 'Free', 'Four']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          height: 250,
          width: screenWidth(context) * 0.9),
    ));
  }

  Widget _buildOverlayContent(BuildContext context) {
    return body(context);
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // You can add your own animations for the overlay content
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}
