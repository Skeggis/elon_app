import 'package:flutter/material.dart';
import 'package:myapp/components/screens/ElonScreen/components/Court.dart';
import 'package:myapp/components/Elon/Elon.dart';
import 'package:myapp/components/screens/ElonScreen/components/SpeedControls.dart';
import 'package:myapp/components/ShotPath/ShotPath.dart';
import 'package:myapp/services/models/DeviceModel.dart';
import 'package:myapp/styles/theme.dart';
import 'package:myapp/components/Ball/Ball.dart';

import "package:vector_math/vector_math.dart" hide Colors;
import "package:bezier/bezier.dart";

class ElonScreenBody extends StatelessWidget {
  Widget mainThings(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Court(),
        SizedBox(height: 25.0),
        Elon(),
        SizedBox(height: 0.0),
        // Align(alignment: Alignment.bottomCenter, child: SpeedControls())
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
    Bezier curve;
    if (drawCurve) {
      curve = new Bezier.fromPoints([
        new Vector2(offsetStart.dx, offsetStart.dy),
        new Vector2(70.0, 95.0),
        new Vector2(offsetEnd.dx, offsetEnd.dy)
      ]);
    }
    //TODO: change curve depending on type of shot.

    bool start = DeviceModel.of(context, rebuildOnChange: true).start;
    return Stack(
      children: [
        RepaintBoundary(child: mainThings(context)),
        drawCurve
            ? RepaintBoundary(
                //https://www.youtube.com/watch?v=Nuni5VQXARo
                child: CustomPaint(
                  foregroundPainter: ShotPathPainter(
                      theColor: MyTheme.secondaryColor,
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
        start && drawCurve
            ? Ball(
                duration: Duration(seconds: 1),
                curve: curve,
              )
            : Container()
      ],
    );
  }
}
