import 'package:flutter/material.dart';
import 'package:myapp/services/helpers.dart';
import 'package:myapp/styles/theme.dart';
import 'package:myapp/services/models/DeviceModel.dart';

class Court extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      margin: EdgeInsets.fromLTRB(10.0, 25.0, 10.0, 0),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: Colors.black, width: 3.0, style: BorderStyle.solid))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 0; i < CourtConfiguration.amountOfRows; i++)
            CourtRow(
              rowNr: i,
            )
        ],
      ),
    );
  }
}

class CourtRow extends StatelessWidget {
  CourtRow({@required this.rowNr});
  final int rowNr;

  @override
  Widget build(BuildContext context) {
    int columns = CourtConfiguration.amountOfColumns;
    const double padding = 3.0 / CourtConfiguration.amountOfColumns;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < columns; i++)
          Padding(
            padding: const EdgeInsets.all(padding),
            child: Square(
              sqrNr: rowNr * columns + i,
            ),
          ),
      ],
    );
  }
}

class Square extends StatefulWidget {
  Square({this.sqrNr});
  final int sqrNr;
  @override
  State<StatefulWidget> createState() => _Square();
}

class _Square extends State<Square> with TickerProviderStateMixin {
  AnimationController animController;
  AnimationController _animController2;
  Animation<double> animation;
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

  void _onTap(BuildContext context) {
    DeviceModel.of(context).changeLocation(widget.sqrNr);
    animController.reset();
    animController.forward();
    DeviceModel.of(context).sendShot(ShotType.drop, widget.sqrNr);
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

    if (animation.status == AnimationStatus.completed ||
        animation.status == AnimationStatus.dismissed) pickedBox = normalBox;

    return pickedBox;
  }

  void _onTapDown(TapDownDetails details, BuildContext context) {
    var x = details.globalPosition.dx;
    var y = details.globalPosition.dy;
    DeviceModel.of(context).changeShotLocation(x, y);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onTap(context),
      onTapDown: (TapDownDetails details) => _onTapDown(details, context),
      child: Container(
        decoration: _getBoxDecoration(context),
        width: screenWidth(context,
            dividedBy:
                (CourtConfiguration.amountOfColumns * (4 / 3)).toDouble()),
        height: screenWidth(context,
            dividedBy: (CourtConfiguration.amountOfRows * 1.25).toDouble()),
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
