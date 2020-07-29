import 'package:flutter/material.dart';
import 'package:myapp/services/helpers.dart';
import 'package:myapp/services/models/DeviceModel.dart';
import 'package:myapp/styles/theme.dart';

import 'package:myapp/components/Elon/Elon.dart';
import 'package:myapp/components/ShotsPicker/ShotsPicker.dart';

import 'package:myapp/components/SetupLoading/SetupLoading.dart';

import 'package:myapp/components/CustomSplashFactory/CustomSplashFactory.dart';

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
    return Container(
      child: RepaintBoundary(
          child: Container(
              height: (screenWidth(context) - 30) * (6.7 / 6.1),
              width: screenWidth(context) - 30,
              child: CustomPaint(
                painter: CourtPainter(),
                child: Container(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                        splashColor: MyTheme.primaryColor,
                        splashFactory: CustomSplashFactory(),
                        highlightColor: Colors.transparent,
                        onTap: () {},
                        onTapDown: (details) => _onTapDown(details, context)),
                  ),
                ),
              ))),
    );
  }

  Widget _playButton(BuildContext context) {
    bool setupLoading =
        DeviceModel.of(context, rebuildOnChange: true).setupLoading;
    return Container(
      decoration:
          BoxDecoration(color: MyTheme.backgroundColor.withOpacity(0.25)),
      child: Center(
        child: !setupLoading
            ? Elon()
            // PlayButton(
            //     onPressed: () => DeviceModel.of(context).flipStart(),
            //     play: false,
            //     width: 75)
            : SetupLoading(text: "Loading..."),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("NewPainting");

    bool start = DeviceModel.of(context, rebuildOnChange: true).start;
    //TODO: change curve depending on type of shot.
    return Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(color: MyTheme.backgroundColor),
      child: Stack(
        children: [
          Align(alignment: Alignment(0, -0.95), child: mainThings(context)),
          Align(alignment: Alignment(0, 0.95), child: ShotsPicker()),
          start ? Container() : Positioned.fill(child: _playButton(context))
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

    double sideMargin = 15;
    double topMargin = 15;

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
    // double dashWidth = 9, dashSpace = 5, startX = backBoundryStart.dx;
    // final netLine = Paint()
    //   ..color = MyTheme.secondaryColor
    //   ..strokeWidth = strokeWidth * 2;
    // while (startX < backBoundryEnd.dx) {
    //   canvas.drawLine(Offset(startX, rightDoublePlaySideLineEnd.dy),
    //       Offset(startX + dashWidth, rightDoublePlaySideLineEnd.dy), netLine);
    //   startX += dashWidth + dashSpace;
    // }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
