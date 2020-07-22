import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import "package:bezier/bezier.dart";

import 'dart:ui' as ui;

class ShotPathPainter extends CustomPainter {
  Color theColor;
  double start;
  double progress;
  Offset offsetStart;
  Offset offsetEnd;
  QuadraticBezier curve;
  ShotPathPainter(
      {this.theColor,
      this.start,
      this.progress = 0.0,
      this.offsetStart,
      this.offsetEnd,
      this.curve});

  @override
  void paint(Canvas canvas, Size size) async {
    Paint outerCircle = Paint()
      ..strokeWidth = 5
      ..color = theColor != null ? theColor : Colors.black
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Path path = Path()
      ..moveTo(this.curve.pointAt(0).x, this.curve.pointAt(0).y);
    for (var i = 1; i < 101; i++) {
      path.lineTo(this.curve.pointAt(i / 100).x, this.curve.pointAt(i / 100).y);
    }
    canvas.drawPath(path, outerCircle);
  }

  // Future<ui.Image> load(String asset) async {
  //   ByteData data = await rootBundle.load(asset);
  //   ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
  //   ui.FrameInfo fi = await codec.getNextFrame();
  //   return fi.image;
  // }

  // void rotate(Canvas c, ui.Image image, Offset focalPoint, Size screenSize,
  //     double angle) {
  //   c.save();
  //   c.translate(screenSize.width / 2, screenSize.height / 2);
  //   c.rotate(angle);
  //   // To rotate around the center of the image, focal point is the
  //   // image width and height divided by 2
  //   c.drawImage(image, focalPoint * -1, Paint());
  //   c.translate(-screenSize.width / 2, -screenSize.height / 2);
  //   c.restore();
  // }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
