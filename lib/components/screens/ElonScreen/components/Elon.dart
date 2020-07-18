import 'package:myapp/services/helpers.dart';
import 'package:flutter/material.dart';
import 'package:myapp/styles/theme.dart';
import 'package:myapp/components/CircularButton/CircularButton.dart';
import 'dart:math' as math;
import './PlayButton.dart';

import 'package:myapp/services/models/DeviceModel.dart';

class Elon extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Elon();
}

class _Elon extends State<Elon> {
  MyTheme myTheme = MyTheme();

  bool isShooting = false;

  void initState() {
    super.initState();
    setState(() {
      isShooting = false;
    });
  }

  void _flipShooting() {
    setState(() {
      isShooting = !isShooting;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = 125.0;
    double height = 125.0 * 0.8;
    double buttonWidth = width * 0.5;
    double shooterWidth = width * 0.4;

    double elonCenter = screenWidth(context, dividedBy: 2) - width / 2;
    double elonTopMargin = shooterWidth / 2 + 10.0;
    double ballWidth = buttonWidth * 0.65;
    return Container(
      height: height * 1.5,
      child: Stack(
        children: [
          Positioned(
              top: elonTopMargin - shooterWidth * 0.3333,
              left: elonCenter + 6,
              child: Shooter(width: shooterWidth)),
          Positioned(
              top: elonTopMargin - shooterWidth * 0.3333,
              left: elonCenter + width - shooterWidth - 6,
              child: Shooter(width: shooterWidth)),
          Positioned(
            top: elonTopMargin,
            left: elonCenter,
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                  color:
                      isShooting ? Colors.transparent : myTheme.secondaryColor,
                  border: Border.all(
                    width: 3.0,
                    color: myTheme.secondaryColor,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
          ),
          isShooting
              ? Positioned(
                  top: elonTopMargin - ballWidth / 2 + height / 2,
                  left: -ballWidth / 2 + elonCenter + width / 2,
                  child: Transform.rotate(
                    angle: 3 * math.pi / 4,
                    child: Image(
                        width: ballWidth,
                        image:
                            AssetImage('assets/images/badminton_ball_500.png')),
                  ),
                )
              : Container(),
          Move(
            startTop: elonTopMargin - buttonWidth / 2 + height / 2,
            endTop: elonTopMargin - buttonWidth / 2 + height / 2,
            startLeft: elonCenter - buttonWidth / 2 + width / 2,
            endLeft: elonCenter + width + buttonWidth / 4,
            buttonWidth: buttonWidth,
            duration: Duration(milliseconds: 750),
            onActivate: _flipShooting,
          ),
        ],
      ),
    );
  }
}

class Move extends StatefulWidget {
  final double startTop;
  final double endTop;
  final double startLeft;
  final double endLeft;
  final Duration duration;
  final double buttonWidth;
  final GestureTapCallback onActivate;

  Move(
      {@required this.startTop,
      @required this.endTop,
      @required this.startLeft,
      @required this.endLeft,
      @required this.duration,
      @required this.buttonWidth,
      this.onActivate});
  @override
  State<StatefulWidget> createState() => _Move();
}

class _Move extends State<Move> with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: widget.duration)
          ..addListener(() {
            setState(() {});
            if (_animationController.status == AnimationStatus.completed ||
                _animationController.status == AnimationStatus.dismissed)
              widget.onActivate();
          });
  }

  void _onTap() {
    model.sendStartStop();
    if (_animationController.status == AnimationStatus.completed) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
  }

  DeviceModel model;

  @override
  Widget build(BuildContext context) {
    model = DeviceModel.of(context);
    return Positioned(
        top: widget.endTop * _animationController.value +
            (1.0 - _animationController.value) * widget.startTop,
        left: widget.endLeft * _animationController.value +
            (1.0 - _animationController.value) * widget.startLeft,
        child: PlayButton(
          width: widget.buttonWidth,
          onPressed: _onTap,
        ));
  }
}

class Shooter extends StatelessWidget {
  Shooter({this.width = 100.0});
  double width;
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
