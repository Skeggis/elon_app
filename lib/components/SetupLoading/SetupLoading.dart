import 'package:flutter/material.dart';
import 'package:myapp/styles/theme.dart';

class SetupLoading extends StatefulWidget {
  String text = "Loading";

  SetupLoading({Key key, this.text}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _SetupLoading();
}

class _SetupLoading extends State<SetupLoading>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2))
          ..addListener(() {
            setState(() {});
          })
          ..repeat();
  }

  @override
  Widget build(BuildContext context) {
    double ballWidth = 25;
    return Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          Text(widget.text, style: TextStyle(color: MyTheme.onPrimaryColor)),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i < 5; i++)
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Opacity(
                    opacity: _animationController.value >= 0.2 + 0.15 * i
                        ? 1.0
                        : 0.25,
                    child: Image(
                        width: ballWidth,
                        image:
                            AssetImage('assets/images/badminton_ball_500.png')),
                  ),
                ),
            ],
          ),
        ]));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
