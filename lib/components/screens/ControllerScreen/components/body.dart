import 'package:flutter/material.dart';
import 'package:myapp/services/helpers.dart';
import 'package:myapp/services/models/DeviceModel.dart';
import 'package:myapp/styles/theme.dart';

import 'package:myapp/components/Elon/Elon.dart';
import 'package:myapp/components/ShotsPicker/ShotsPicker.dart';

import 'dart:math' as math;

import "package:vector_math/vector_math.dart" hide Colors;
import "package:bezier/bezier.dart";

import 'package:myapp/components/ShotPath/ShotPath.dart';
import 'package:myapp/components/Ball/Ball.dart';

class ControllerScreenBody extends StatelessWidget {
  void _onTapDown(TapDownDetails details, BuildContext context) {
    Size courtSize = Size(
        screenWidth(context) - 80, (screenWidth(context) - 80) * (6.7 / 6.1));
    DeviceModel.of(context).changeShotLocation(
        details.globalPosition, details.localPosition, courtSize);

    double upDownProportion = (details.localPosition.dy / courtSize.height);
    double leftRighProportion = (details.localPosition.dx / courtSize.width);
    DeviceModel.of(context).sendShot(
        leftRightProportion: leftRighProportion,
        upDownProportion: upDownProportion,
        shotType: DeviceModel.of(context).shotType,
        globalShotPosition: details.globalPosition);
  }

  Widget mainThings(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      //crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 15),
        GestureDetector(
          onTapDown: (TapDownDetails details) => _onTapDown(details, context),
          child: Container(
            child: RepaintBoundary(
                child: Container(
              height: (screenWidth(context) - 80) * (6.7 / 6.1),
              width: screenWidth(context) - 80,
              child: CustomPaint(
                painter: CourtPainter(),
              ),
            )),
          ),
        ),
        SizedBox(height: 10.0),
        Elon(),
        SizedBox(height: 10.0),
        ShotsPicker()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    print("NewPainting");
    Offset offsetEnd =
        DeviceModel.of(context, rebuildOnChange: true).globalShotLocation;
    Offset offsetStart =
        DeviceModel.of(context, rebuildOnChange: true).offsetDevice;

    bool drawCurve = offsetStart != null && offsetEnd != null;

    bool start = DeviceModel.of(context, rebuildOnChange: true).start;
    Bezier curve = DeviceModel.of(context).curve;

    List<Shot> animatedQueue =
        DeviceModel.of(context, rebuildOnChange: true).animateQueue;

    List<Widget> animation = [];
    if (animatedQueue.length > 0 && start) {
      var i = 0;
      for (Shot shot in animatedQueue) {
        animation.add(Ball(
          duration: Duration(seconds: 1),
          curve: shot.curve,
          key: Key("$i" + shot.toString()),
        ));
      }
    }
    //TODO: change curve depending on type of shot.
    return Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(color: MyTheme.courtColor),
      child: Stack(
        children: [
          mainThings(context),
          drawCurve && !start
              ? RepaintBoundary(
                  //https://www.youtube.com/watch?v=Nuni5VQXARo
                  child: CustomPaint(
                    foregroundPainter: ShotPathPainter(
                        theColor: MyTheme.backgroundColor,
                        curve: curve,
                        start: 0.0,
                        offsetEnd: offsetEnd,
                        offsetStart: offsetStart),
                    child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        child: SizedBox.expand()),
                  ),
                )
              : Container(),
          ...animation
        ],
      ),
    );
  }
}

class CourtPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    print(size.width);
    double strokeWidth = 2;
    Paint line = new Paint()
      ..strokeCap = StrokeCap.round
      ..color = MyTheme.onPrimaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    double realBackBoundryLength = 6.1; //meters
    double realDoublePlaySideLineLength = 6.7; //meters

    //Gaps
    double realBackBoundryLongServiceGap = 0.76; //meters
    double realDropLineLongServiceGap = 3.96; //meters
    double realDoubleSinglePlaySideLineGap = 0.46; //meters

    double sideMargin = 5;
    double topMargin = 5;

    /* --------Horizontal Lines--------- */

    Offset backBoundryStart = Offset(sideMargin, topMargin);
    Offset backBoundryEnd = Offset(size.width - sideMargin, topMargin);
    double backBoundryLength = backBoundryEnd.dx - backBoundryStart.dx;
    //Back Boundry:
    canvas.drawLine(backBoundryStart, backBoundryEnd, line);

    Offset longServiceStart = Offset(
        backBoundryStart.dx,
        sideMargin +
            backBoundryLength *
                (realBackBoundryLongServiceGap / realBackBoundryLength));
    Offset longServiceEnd = Offset(backBoundryEnd.dx, longServiceStart.dy);
    //Long service line:
    canvas.drawLine(longServiceStart, longServiceEnd, line);

    Offset dropLineStart = Offset(
        backBoundryStart.dx,
        longServiceStart.dy +
            backBoundryLength *
                (realDropLineLongServiceGap / realBackBoundryLength));
    Offset dropLineEnd = Offset(backBoundryEnd.dx, dropLineStart.dy);

    //Drop line:
    canvas.drawLine(dropLineStart, dropLineEnd, line);

    /* --------Vertical Lines--------- */

    Offset leftDoublePlaySideLineStart = backBoundryStart;
    Offset leftDoublePlaySideLineEnd = Offset(
        leftDoublePlaySideLineStart.dx,
        backBoundryLength *
            (realDoublePlaySideLineLength / realBackBoundryLength));
    //Left Side Line for double play:
    canvas.drawLine(
        leftDoublePlaySideLineStart, leftDoublePlaySideLineEnd, line);

    Offset rightDoublePlaySideLineStart = backBoundryEnd;
    Offset rightDoublePlaySideLineEnd = Offset(
        rightDoublePlaySideLineStart.dx,
        backBoundryLength *
            (realDoublePlaySideLineLength / realBackBoundryLength));
    //Right Side Line for double play:
    canvas.drawLine(
        rightDoublePlaySideLineStart, rightDoublePlaySideLineEnd, line);

    Offset leftSinglePlaySideLineStart = Offset(
        leftDoublePlaySideLineStart.dx +
            backBoundryLength *
                (realDoubleSinglePlaySideLineGap / realBackBoundryLength),
        backBoundryStart.dy);
    Offset leftSinglePlaySideLineEnd =
        Offset(leftSinglePlaySideLineStart.dx, leftDoublePlaySideLineEnd.dy);

    //Left Side Line for Single Play:
    canvas.drawLine(
        leftSinglePlaySideLineStart, leftSinglePlaySideLineEnd, line);

    Offset rightSinglePlaySideLineStart = Offset(
        rightDoublePlaySideLineStart.dx -
            backBoundryLength *
                (realDoubleSinglePlaySideLineGap / realBackBoundryLength),
        backBoundryStart.dy);
    Offset rightSinglePlaySideLineEnd =
        Offset(rightSinglePlaySideLineStart.dx, rightDoublePlaySideLineEnd.dy);

    //Left Side Line for Single Play:
    canvas.drawLine(
        rightSinglePlaySideLineStart, rightSinglePlaySideLineEnd, line);

    //Center line
    canvas.drawLine(Offset(size.width / 2, backBoundryStart.dy),
        Offset(size.width / 2, dropLineEnd.dy), line);

/* --------Net, DASHED, Line--------- */

    //Net:
    double dashWidth = 9, dashSpace = 5, startX = backBoundryStart.dx;
    final netLine = Paint()
      ..color = MyTheme.secondaryColor
      ..strokeWidth = strokeWidth * 2;
    while (startX < backBoundryEnd.dx) {
      canvas.drawLine(Offset(startX, rightDoublePlaySideLineEnd.dy),
          Offset(startX + dashWidth, rightDoublePlaySideLineEnd.dy), netLine);
      startX += dashWidth + dashSpace;
    }

    /* --------Half Circles--------- */

    Paint circles = new Paint()
      ..strokeCap = StrokeCap.round
      ..color = MyTheme.onPrimaryColor
      ..style = PaintingStyle.fill;

    double circleRadius = 10;
    Offset leftCircleCenter = Offset(
        leftDoublePlaySideLineStart.dx + strokeWidth / 2,
        leftDoublePlaySideLineEnd.dy);

    //LeftCircle
    canvas.drawArc(
        Rect.fromCircle(center: leftCircleCenter, radius: circleRadius),
        math.pi / 2,
        math.pi,
        true,
        circles);

    Offset rightCircleCenter = Offset(
        rightDoublePlaySideLineStart.dx - strokeWidth / 2,
        rightDoublePlaySideLineEnd.dy);

    //RightCircle
    canvas.drawArc(
        Rect.fromCircle(center: rightCircleCenter, radius: circleRadius),
        math.pi / 2,
        -math.pi,
        true,
        circles);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
