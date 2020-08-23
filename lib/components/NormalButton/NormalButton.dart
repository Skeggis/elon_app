import 'package:flutter/material.dart';

class NormalButton extends StatelessWidget {
  NormalButton(
      {@required this.onPressed, @required this.title, this.fillColor});
  final GestureTapCallback onPressed;
  final String title;
  final Color fillColor;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: this.fillColor != null ? this.fillColor : null,
      child: Text(
        this.title != null ? this.title : "Tap Me",
        maxLines: 1,
        style: TextStyle(fontSize: 15),
      ),
      onPressed: onPressed,
    );
  }
}
