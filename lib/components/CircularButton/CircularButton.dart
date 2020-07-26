import 'package:flutter/material.dart';
import 'dart:math' as math;

class CircularButton extends StatelessWidget {
  CircularButton(
      {this.width = 20.0,
      this.onPressed,
      this.icon,
      this.color,
      this.borderColor,
      this.splashColor,
      this.isSelected = false});
  final GestureTapCallback onPressed;
  final Icon icon;
  final double width;
  final bool isSelected;
  final Color color;
  final Color borderColor;
  final Color splashColor;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: this.onPressed,
      elevation: 0.0,
      constraints: BoxConstraints.tight(Size(width, width)),
      fillColor: color,
      highlightColor: Colors.transparent,
      splashColor: this.splashColor != null ? splashColor : Colors.grey,
      child: this.icon,

      // padding: EdgeInsets.all(15.0),
      shape: CircleBorder(
        side: this.isSelected && this.borderColor != null
            ? BorderSide(
                width: 4.0, color: this.borderColor, style: BorderStyle.solid)
            : BorderSide.none,
      ),
    );
  }
}

class CircularAnimatedButton extends StatefulWidget {
  CircularAnimatedButton(
      {this.width = 20.0,
      this.onPressed,
      this.icon,
      this.color,
      this.borderColor,
      this.splashColor,
      this.endColor,
      this.endIcon,
      this.isSelected = false});
  final GestureTapCallback onPressed;
  final Icon icon;
  final double width;
  final bool isSelected;
  final Color color;
  final Color endColor;
  final Icon endIcon;
  final Color borderColor;
  final Color splashColor;

  final _CircularAnimatedButton circ = _CircularAnimatedButton();
  @override
  State<StatefulWidget> createState() => circ;

  void animate() {
    circ.animate();
  }
}

class _CircularAnimatedButton extends State<CircularAnimatedButton>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    setState(() => {});

    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _animation =
        Tween<double>(begin: 0.0, end: 100).animate(_animationController)
          ..addListener(() {
            setState(() {});
          });
  }

  void animate() {
    if (_animationController.status == AnimationStatus.dismissed)
      _animationController.forward();
    else
      _animationController.reverse();
    // widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: widget.onPressed,
      elevation: 0.0,
      constraints: BoxConstraints.tight(Size(widget.width, widget.width)),
      fillColor: widget.color,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: CustomPaint(
          painter: MyPainter(
              theColor: widget.borderColor,
              start: 0.0,
              end: _animation.value,
              progress: _animation.value),
          // size: Size(widget.width * 0.5, widget.width * 0.5),
          child: widget.icon),
      shape: CircleBorder(
        side: widget.isSelected && widget.borderColor != null
            ? BorderSide(
                width: 4.0, color: widget.borderColor, style: BorderStyle.solid)
            : BorderSide.none,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

// This is the Painter class
class MyPainter extends CustomPainter {
  Color theColor;
  double start;
  double end;
  double progress;
  MyPainter({this.theColor, this.start, this.end, this.progress = 0.0});

  @override
  void paint(Canvas canvas, Size size) {
    //this is base circle
    Paint outerCircle = Paint()
      ..strokeWidth = 5
      ..color = theColor != null ? theColor : Colors.black
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = math.min(size.width / 2, size.height / 2) + 5;

    double angle = 2 * math.pi * (this.progress / 100);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), 0, angle,
        false, outerCircle);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
