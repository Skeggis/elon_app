import 'package:flutter/material.dart';
import 'package:myapp/services/models/Enums.dart';
import 'package:myapp/styles/theme.dart';

class ShotTypeWidget extends StatelessWidget {
  bool picked;
  ShotType type;
  Function onClick;
  ShotTypeWidget(
      {this.type = ShotType.serve, this.picked = false, this.onClick});
  @override
  Widget build(BuildContext context) {
    Color color;
    String title;
    switch (this.type) {
      case ShotType.clear:
        color = MyTheme.clearColor;
        title = "Clear";
        break;
      case ShotType.drive:
        color = MyTheme.driveColor;
        title = "Drive";
        break;
      case ShotType.drop:
        color = MyTheme.dropColor;
        title = "Drop";
        break;
      case ShotType.serve:
        color = MyTheme.serveColor;
        title = "Serve";
        break;
      case ShotType.smash:
        color = MyTheme.smashColor;
        title = "Smash";
        break;
      default:
    }

    return MaterialButton(
        padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
        onPressed: this.onClick,
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: color, width: 3)),
        color: this.picked ? color : color.withOpacity(0.15),
        textColor: this.picked ? MyTheme.onPrimaryColor : color,
        child: Text(title, style: TextStyle(fontSize: 20)));
  }
}
