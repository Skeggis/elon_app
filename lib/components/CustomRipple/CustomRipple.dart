import 'package:flutter/material.dart';
import 'package:myapp/services/models/DeviceModel.dart';
import 'package:myapp/styles/theme.dart';

class CustomRipple extends StatefulWidget {
  final double maxDiameter;
  final Offset position;

  CustomRipple(
      {Key key, this.maxDiameter = 100, this.position = const Offset(0, 0)})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => _CustomRipple();
}

class _CustomRipple extends State<CustomRipple>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      lowerBound: 0.5,
      duration: Duration(seconds: 3),
    )..addListener(() {
        setState(() => {});
      });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller.status == AnimationStatus.completed) {
      print("Dequeue");
      DeviceModel.of(context).dequeueAnimateQueue();
    }
    return Positioned(
        top: widget.position.dy - 60,
        left: widget.position.dx - 35,
        child: Container(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              _buildContainer(0.22 * widget.maxDiameter * _controller.value),
              _buildContainer(0.42 * widget.maxDiameter * _controller.value),
              _buildContainer(0.57 * widget.maxDiameter * _controller.value),
              _buildContainer(0.71 * widget.maxDiameter * _controller.value),
              _buildContainer(0.85 * widget.maxDiameter * _controller.value),
              _buildContainer(widget.maxDiameter * _controller.value),
            ],
          ),
        ));
  }

  // Widget _buildBody() {
  //   return AnimatedBuilder(
  //     animation:
  //         CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn),
  //     builder: (context, child) {

  //       return
  //     },
  //   );
  // }

  Widget _buildContainer(double diameter) {
    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: MyTheme.primaryColor.withOpacity(1 - _controller.value),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
