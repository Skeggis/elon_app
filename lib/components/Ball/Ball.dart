import 'package:flutter/material.dart';
import "package:bezier/bezier.dart";
import "package:vector_math/vector_math.dart" hide Colors;
import 'package:myapp/services/models/DeviceModel.dart';

class BallAnimation extends AnimatedWidget {
  BallAnimation(
      {Key key, AnimationController controller, this.curve, this.child})
      : super(key: key, listenable: controller);

  Animation<double> get _progress => listenable;
  QuadraticBezier curve;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    if (this.curve == null) {
      return SizedBox(height: 1);
    }
    Vector2 currentPoint = this.curve.pointAt(_progress.value);
    return Positioned(
        top: currentPoint.y - 30, left: currentPoint.x - 7.5, child: child);
  }
}

class Ball extends StatefulWidget {
  Duration duration;
  QuadraticBezier curve;
  Ball({@required this.duration, this.curve});
  @override
  State<StatefulWidget> createState() => _Ball();
}

class _Ball extends State<Ball> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: widget.duration)
          ..addListener(() {
            setState(() => {});
          });

    _animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    double ballWidth = 35;
    return BallAnimation(
      controller: _animationController,
      curve: widget.curve,
      child: Image(
          width: ballWidth,
          image: AssetImage('assets/images/black_badminton_ball_500.png')),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
