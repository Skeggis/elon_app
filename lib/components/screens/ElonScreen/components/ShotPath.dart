import 'package:flutter/material.dart';
import 'package:myapp/styles/theme.dart';
import 'package:myapp/services/helpers.dart';

import "package:vector_math/vector_math.dart";
import "package:bezier/bezier.dart";

class ShotPath extends StatelessWidget {
  final MyTheme myTheme = MyTheme();

  final Offset offsetEnd;
  final Offset offsetStart;
  ShotPath({@required this.offsetEnd, @required this.offsetStart});
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        painter: ShotPathPainter(
            theColor: myTheme.secondaryColor,
            start: 0.0,
            offsetEnd: this.offsetEnd,
            offsetStart: this.offsetStart),
        child: Align(
          alignment: Alignment.topLeft,
          child: SizedBox.fromSize(size: screenSize(context)),
        ));
  }
}

class ShotPathPainter extends CustomPainter {
  Color theColor;
  double start;
  double progress;
  Offset offsetStart;
  Offset offsetEnd;
  ShotPathPainter(
      {this.theColor,
      this.start,
      this.progress = 0.0,
      this.offsetStart,
      this.offsetEnd});

  @override
  void paint(Canvas canvas, Size size) {
    Paint outerCircle = Paint()
      ..strokeWidth = 5
      ..color = theColor != null ? theColor : Colors.black
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    this.offsetStart =
        this.offsetStart == null ? Offset(0, 0) : this.offsetStart;
    this.offsetEnd = this.offsetEnd == null ? Offset(100, 100) : this.offsetEnd;
    canvas.drawLine(this.offsetStart, this.offsetEnd, outerCircle);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
