import 'package:flutter/material.dart';
import 'package:myapp/services/helpers.dart';
import 'package:myapp/styles/theme.dart';
// import 'dart:math' as math;

typedef SquareTap = Function(int nr);

class Court extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Court();
}

class _Court extends State<Court> {
  MyTheme myTheme = MyTheme();

  int squarePicked;
  void initState() {
    super.initState();
    setState(() {
      squarePicked = 0;
    });
  }

  void _onSquareTap(int nr) {
    setState(() {
      squarePicked = nr;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      margin: EdgeInsets.fromLTRB(10.0, 25.0, 10.0, 0),
      decoration: BoxDecoration(
          // color: Colors.blue,
          border: Border(
              bottom: BorderSide(
                  color: Colors.black, width: 3.0, style: BorderStyle.solid))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CourtRow(
            rowNr: 0,
            sqrPickedNr: squarePicked,
            onPressed: _onSquareTap,
          ),
          CourtRow(
            rowNr: 1,
            sqrPickedNr: squarePicked,
            onPressed: _onSquareTap,
          ),
          CourtRow(
            rowNr: 2,
            sqrPickedNr: squarePicked,
            onPressed: _onSquareTap,
          )
        ],
      ),
    );
  }
}

class Square extends StatefulWidget {
  Square({@required this.picked, this.hit = false, this.sqrNr, this.onPressed});
  bool picked;
  bool hit;
  int sqrNr;
  SquareTap onPressed;
  @override
  State<StatefulWidget> createState() => _Square();
}

class _Square extends State<Square> with TickerProviderStateMixin {
  AnimationController animController;
  AnimationController _animController2;
  Animation<double> animation;
  Animation<double> _animation2;
  void initState() {
    super.initState();
    animController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    _animController2 = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _animation2 = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_animController2)
      ..addListener(() {
        setState(() {});
      });
    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(animController)
      ..addListener(() {
        setState(() {});
        if (animController.status == AnimationStatus.completed) {
          _animController2.reset();
          _animController2.forward();
        }
      });
  }

  void _onTap() {
    widget.onPressed(widget.sqrNr);
  }

  void _onDoubleTap() {
    if (!widget.picked) return;
    animController.reset();
    animController.forward();
  }

  BoxDecoration _getBoxDecoration(BuildContext context) {
    BoxDecoration normalBox =
        BoxDecoration(color: Theme.of(context).primaryColor);

    BoxDecoration pickedBox = BoxDecoration(
        gradient: RadialGradient(colors: [
      Theme.of(context).primaryColor,
      Color(0xFF191919),
      Color(0xFF232627),
      Theme.of(context).primaryColor
    ], stops: [
      animation.value - 0.2,
      animation.value,
      animation.value + 0.75,
      animation.value + 0.99
    ]));

    if (animation.value == 1.0) {
      //Other animation:
      // pickedBox = BoxDecoration(
      //     gradient: RadialGradient(colors: [
      //   Color(0xFF191919),
      //   Color(0xFF232627),
      //   Theme.of(context).primaryColor,
      // ], stops: [
      //   _animation2.value - 0.4,
      //   _animation2.value - 0.25,
      //   _animation2.value + 0.95,
      // ]));
      pickedBox = BoxDecoration(
          gradient: RadialGradient(colors: [
        Theme.of(context).primaryColor,
        Color(0xFF191919),
        Color(0xFF232627),
        Theme.of(context).primaryColor
      ], stops: [
        0.8 - _animation2.value,
        1.0 - _animation2.value,
        1.75 - _animation2.value,
        1.99 - _animation2.value
      ]));
    }

    return widget.picked ? pickedBox : normalBox;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      onDoubleTap: _onDoubleTap,
      child: Container(
        decoration: _getBoxDecoration(context),
        width: screenWidth(context, dividedBy: 4),
        height: screenWidth(context, dividedBy: 3.75),
      ),
    );
  }

  @override
  void dispose() {
    animController.dispose();
    _animController2.dispose();
    super.dispose();
  }
}

class CourtRow extends StatelessWidget {
  CourtRow({@required this.rowNr, this.sqrPickedNr = 0, this.onPressed});
  final int rowNr;
  final int sqrPickedNr;
  final SquareTap onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(1.0),
          child: Square(
            hit: false,
            picked: rowNr * 3 + 0 == sqrPickedNr,
            sqrNr: rowNr * 3 + 0,
            onPressed: onPressed,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(1.0),
          child: Square(
            sqrNr: rowNr * 3 + 1,
            hit: false,
            picked: rowNr * 3 + 1 == sqrPickedNr,
            onPressed: onPressed,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(1.0),
          child: Square(
            sqrNr: rowNr * 3 + 2,
            hit: false,
            picked: rowNr * 3 + 2 == sqrPickedNr,
            onPressed: onPressed,
          ),
        )
      ],
    );
  }
}
