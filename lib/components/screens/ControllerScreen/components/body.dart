import 'package:flutter/material.dart';
import 'package:myapp/services/models/DeviceModel.dart';
import 'package:myapp/styles/theme.dart';

import 'dart:math' as math;

class ControllerScreenBody extends StatelessWidget {
  Widget mainThings(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(color: MyTheme.courtColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomPaint(
            painter: CourtPainter(),
          ),
          SizedBox(height: 25.0),
          // Controller(),
          SizedBox(height: 0.0),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        mainThings(context),
      ],
    );
  }
}

class CourtPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
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

    double margin = 25;

    /* --------Horizontal Lines--------- */

    Offset backBoundryStart = Offset(margin, margin);
    Offset backBoundryEnd = Offset(size.width - margin, margin);
    double backBoundryLength = backBoundryEnd.dx - backBoundryStart.dx;
    //Back Boundry:
    canvas.drawLine(backBoundryStart, backBoundryEnd, line);

    Offset longServiceStart = Offset(
        backBoundryStart.dx,
        margin +
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
