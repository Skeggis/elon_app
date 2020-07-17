import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {@required this.onPressed,
      @required this.title,
      @required this.isSelected,
      this.icon,
      this.size,
      this.padding});
  final GestureTapCallback onPressed;
  final String title;
  final bool isSelected;
  final Size size;
  final Icon icon;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
        elevation: 0,
        focusColor: Colors.red,
        highlightColor: Colors.transparent,
        splashColor: isSelected
            ? Theme.of(context).primaryColor
            : Theme.of(context).splashColor,
        constraints: size != null
            ? BoxConstraints.tight(size)
            : BoxConstraints(minHeight: 40.0),
        padding: this.padding == null
            ? EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0)
            : this.padding,
        fillColor: this.isSelected
            ? Colors.transparent
            : Theme.of(context).primaryColor,
        child: icon == null
            ? Container(
                child: Center(
                  child: Text(
                    this.title != null ? this.title : "Tap Me",
                    maxLines: 1,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              )
            : Row(
                children: [
                  Text(
                    this.title != null ? this.title : "Tap Me",
                    maxLines: 1,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  icon
                ],
              ),
        onPressed: onPressed,
        shape: new RoundedRectangleBorder(
            side: BorderSide(
                width: 2.0,
                color: Theme.of(context).primaryColor,
                style: BorderStyle.solid),
            borderRadius: new BorderRadius.circular(5.0)));
  }
}
