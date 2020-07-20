import 'package:flutter/material.dart';
import 'package:myapp/components/screens/ElonScreen/components/Court.dart';
import 'package:myapp/components/screens/ElonScreen/components/Elon.dart';
import 'package:myapp/components/screens/ElonScreen/components/SpeedControls.dart';
import 'package:myapp/components/screens/ElonScreen/components/ShotPath.dart';
import 'package:myapp/services/models/DeviceModel.dart';
import 'package:myapp/styles/theme.dart';

class ElonScreenBody extends StatelessWidget {
  final MyTheme myTheme = MyTheme();
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
    Offset offsetEnd =
        DeviceModel.of(context, rebuildOnChange: true).offsetLocation;
    Offset offsetStart =
        DeviceModel.of(context, rebuildOnChange: true).offsetDevice;
    return CustomPaint(
      foregroundPainter: ShotPathPainter(
          theColor: myTheme.secondaryColor,
          start: 0.0,
          offsetEnd: offsetEnd,
          offsetStart: offsetStart),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [mainThings(context)],
        ),
      ),
    );
  }
}
