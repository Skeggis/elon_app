import 'package:myapp/services/helpers.dart';
import 'package:flutter/material.dart';
import 'package:myapp/styles/theme.dart';
import 'dart:math' as math;
import '../PlayButton/PlayButton.dart';

import 'package:myapp/services/models/scopedModels/DeviceModel.dart';
import 'package:myapp/services/extensions.dart';

class Elon extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Elon();
}

class _Elon extends State<Elon> {
  final containerKey = GlobalKey();
  Rect get containerRect => containerKey.globalPaintBounds;

  @override
  Widget build(BuildContext context) {
    bool start = DeviceModel.of(context, rebuildOnChange: true).start;

    double width = screenWidth(context) * 0.25;
    double height = width * 0.8;
    double buttonWidth = width * 0.5;
    double shooterWidth = width * 0.4;

    double elonCenter = screenWidth(context, dividedBy: 2) - width / 2;
    double elonTopMargin = shooterWidth / 2 + 10.0;
    double ballWidth = buttonWidth * 0.65;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      DeviceModel.of(context)
          .setOffsetDevice(containerKey.globalPaintBounds.topCenter);
    });

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
            key: containerKey,
            top: elonTopMargin,
            left: elonCenter,
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 50, color: Colors.black.withOpacity(0.45))
                  ],
                  color: start ? Colors.transparent : Theme.of(context).backgroundColor,
                  border: Border.all(
                    width: 3.0,
                    // color: MyTheme.backgroundColor,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
          ),
          Move(
            startTop: elonTopMargin - buttonWidth / 2 + height / 2,
            endTop: elonTopMargin - buttonWidth / 2 + height / 2,
            startLeft: elonCenter - buttonWidth / 2 + width / 2,
            endLeft: elonCenter + width + buttonWidth / 4,
            buttonWidth: buttonWidth,
            duration: Duration(milliseconds: 750),
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

  Move(
      {@required this.startTop,
      @required this.endTop,
      @required this.startLeft,
      @required this.endLeft,
      @required this.duration,
      @required this.buttonWidth});
  @override
  State<StatefulWidget> createState() => _Move();
}

class _Move extends State<Move> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  DeviceModel model;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: widget.duration)
          ..addListener(() {
            setState(() {});
          });
  }

  void _onTap(BuildContext context) {
    model.flipStart();
  }

  @override
  Widget build(BuildContext context) {
    model = DeviceModel.of(context);
    bool start = DeviceModel.of(context, rebuildOnChange: true).start;
    if (start && (_animationController.status == AnimationStatus.dismissed)) {
      _animationController.forward();
    } else if (!start &&
        (_animationController.status == AnimationStatus.completed)) {
      _animationController.reverse();
    }
    return Positioned(
        top: widget.endTop * _animationController.value +
            (1.0 - _animationController.value) * widget.startTop,
        left: widget.endLeft * _animationController.value +
            (1.0 - _animationController.value) * widget.startLeft,
        child: PlayButton(
            width: widget.buttonWidth,
            onPressed: () => _onTap(context),
            play: start));
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
