import 'package:flutter/material.dart';
import 'package:myapp/components/screens/ElonScreen/components/Court.dart';
import 'package:myapp/components/screens/ElonScreen/components/Elon.dart';
import 'package:myapp/components/screens/ElonScreen/components/SpeedControls.dart';

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
    return Container(
      child: Stack(
        children: [mainThings(context)],
      ),
    );
  }
}
