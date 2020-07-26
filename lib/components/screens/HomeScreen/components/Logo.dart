import 'package:flutter/material.dart';
import 'package:myapp/services/helpers.dart';
import 'package:myapp/styles/theme.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = 125.0;
    double height = 125.0 * 0.7;

    double shooterWidth = width * 0.4;

    double containerWidth = width + 15;
    double containerHeight = height + 30;

    double ballWidth = 35;
    return Container(
      height: containerHeight,
      width: containerWidth,
      child: Stack(
        children: [
          Positioned(
              top: 10,
              left: containerWidth * 0.5 - width * 0.5 + 10,
              child: Shooter(width: shooterWidth)),
          Positioned(
              top: 10,
              left: containerWidth * 0.5 + width * 0.5 - shooterWidth - 10,
              child: Shooter(width: shooterWidth)),
          Align(
            alignment: Alignment(0, 0.75),
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 4),
                        blurRadius: 10,
                        color: Color.fromRGBO(0, 0, 0, 0.25))
                  ],
                  color: MyTheme.backgroundColor,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
          ),
          Align(
            alignment: Alignment(0,
                0.75 - height / containerHeight + ballWidth / containerHeight),
            child: Image(
                width: ballWidth,
                image: AssetImage('assets/images/badminton_ball_500.png')),
          ),
        ],
      ),
    );
  }
}

class Shooter extends StatelessWidget {
  Shooter({this.width = 100.0});
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Theme.of(context).primaryColor,
      height: width,
      width: width,
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: Theme.of(context).primaryColor),
    );
  }
}
