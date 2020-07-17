import 'package:flutter/material.dart';
import 'package:myapp/components/CircularButton/CircularButton.dart';
import 'package:myapp/styles/theme.dart';
import 'dart:math' as math;

class SpeedControls extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SpeedControls();
}

class _SpeedControls extends State<SpeedControls> {
  MyTheme myTheme = MyTheme();
  int bpm;
  void initState() {
    super.initState();
    setState(() {
      bpm = 30;
    });
  }

  void _changeBPM(int add) {
    setState(() {
      bpm += add;
      if (bpm < 0) bpm = 0;
      if (bpm > 60) bpm = 60;
    });
  }

  Widget _textStuff() {
    double ballWidth = 25;
    return Row(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
          child: Text(
            bpm.toString(),
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w700, fontSize: 30),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(15, 0, 0, 15),
          child: Image(
              width: ballWidth,
              image: AssetImage('assets/images/badminton_ball_500.png')),
        ),
        Text(
          '/mín',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  Widget _buttons(BuildContext context) {
    return Column(
      children: [
        CircularButton(
          onPressed: () => _changeBPM(1),
          splashColor: myTheme.secondaryColor,
          color: Theme.of(context).primaryColor,
          width: 40,
          icon: Icon(Icons.keyboard_arrow_up,
              size: 35.0, color: Theme.of(context).backgroundColor),
        ),
        CircularButton(
          onPressed: () => _changeBPM(-1),
          splashColor: myTheme.secondaryColor,
          color: Theme.of(context).primaryColor,
          width: 40,
          icon: Icon(Icons.keyboard_arrow_down,
              size: 35.0, color: Theme.of(context).backgroundColor),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(width: 100.0),
        _textStuff(),
        SizedBox(width: 30.0),
        _buttons(context)
      ],
    );
  }
}
