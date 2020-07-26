import 'package:flutter/material.dart';
import 'package:myapp/services/helpers.dart';

// import 'package:scoped_model/scoped_model.dart';
import 'package:myapp/services/models/UIModel.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:myapp/styles/theme.dart';

class WithSideBar extends StatelessWidget {
  final Widget child;
  WithSideBar({this.child});

  @override
  Widget build(BuildContext context) {
    return ScopedModel<UIModel>(
      model: UIModel(),
      child: WithSideBarBody(child: child),
    );
  }
}

class WithSideBarBody extends StatefulWidget {
  final Widget child;
  WithSideBarBody({@required this.child});
  @override
  State<StatefulWidget> createState() => _WithSideBarBody();
}

class _WithSideBarBody extends State<WithSideBarBody>
    with SingleTickerProviderStateMixin {
  final double sideBarWidth = 200;

  AnimationController _animationController;

  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300))
          ..addListener(() {
            setState(() {});
          });
  }

  void _onScreenTap(BuildContext context) {
    bool isOpen = UIModel.of(context).isSideBarOpen;
    if (isOpen) {
      UIModel.of(context).toggleSideBarOpen();
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isOpen = UIModel.of(context, rebuildOnChange: true).isSideBarOpen;
    if (_animationController.status == AnimationStatus.completed && !isOpen) {
      _animationController.reverse();
    } else if (_animationController.status == AnimationStatus.dismissed &&
        isOpen) {
      _animationController.forward();
    }

    Widget thing;

    if (isOpen) {
      thing = GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _onScreenTap(context),
        child: IgnorePointer(
          child: Container(
              width: screenWidth(context),
              height: screenHeight(context),
              child: widget.child),
        ),
      );
    } else {
      thing = Container(
          width: screenWidth(context),
          height: screenHeight(context),
          child: widget.child);
    }

    return Stack(
      children: [
        Positioned(
            left: -sideBarWidth * (1 - _animationController.value),
            child: SideBar(width: sideBarWidth)),
        Positioned(
          left: sideBarWidth * _animationController.value,
          child: thing,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class SideBar extends StatelessWidget {
  double width;
  SideBar({
    this.width = 100,
  });
  @override
  Widget build(BuildContext context) {
    double height = screenHeight(context);
    return Container(
      width: this.width,
      height: height,
      decoration: BoxDecoration(color: MyTheme.barBackgroundColor),
      child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [],
          )),
    );
  }
}
