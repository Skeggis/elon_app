import 'package:flutter/material.dart';
import '../../styles/theme.dart';
import 'dart:math' as math;

class PlayButton extends StatefulWidget {
  final double width;
  final GestureTapCallback onPressed;
  final bool play;
  PlayButton({this.width = 50.0, this.onPressed, this.play});
  @override
  State<StatefulWidget> createState() => _PlayButton();
}

class _PlayButton extends State<PlayButton>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 750))
          ..addListener(() {
            setState(() {});
          });
  }

  void _onTap() {
    if (widget.onPressed != null) widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.play &&
        (_animationController.status == AnimationStatus.dismissed)) {
      _animationController.forward();
    } else if (!widget.play &&
        (_animationController.status == AnimationStatus.completed)) {
      _animationController.reverse();
    }
    return RawMaterialButton(
      onPressed: _onTap,
      elevation: 0.0,
      constraints: BoxConstraints.tight(Size(widget.width, widget.width)),
      fillColor: MyTheme.onPrimaryColor,
      shape: CircleBorder(),
      child: PlayButtonAnimations(
        controller: _animationController,
        child: Icon(widget.play ? Icons.pause : Icons.play_arrow,
            color: MyTheme.backgroundColor, size: widget.width * 0.75),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class PlayButtonAnimations extends AnimatedWidget {
  PlayButtonAnimations({Key key, AnimationController controller, this.child})
      : super(key: key, listenable: controller);

  Animation<double> get _progress => listenable;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: 2 * math.pi * _progress.value,
      child: CustomPaint(
          painter: MyPainter(
            theColor: MyTheme.backgroundColor,
            start: 0.0,
            progress: _progress.value,
          ),
          child: this.child),
    );
  }
}

class MyPainter extends CustomPainter {
  Color theColor;
  double start;
  double progress;
  MyPainter({this.theColor, this.start, this.progress = 0.0});

  @override
  void paint(Canvas canvas, Size size) {
    Paint outerCircle = Paint()
      ..strokeWidth = 4
      ..color = MyTheme.backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = math.min(size.width / 2, size.height / 2) + 5;

    double angle = 2 * math.pi * (this.progress);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), 0, angle,
        false, outerCircle);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
