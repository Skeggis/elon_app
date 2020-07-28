import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/components/CustomButton/CustomButton.dart';
import 'package:myapp/services/helper.dart';
import 'package:myapp/services/models/DeviceModel.dart';
import 'package:myapp/services/models/Program.dart';

class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Program currentProgram =
        DeviceModel.of(context, rebuildOnChange: true).currentProgram;
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
          ),
        ],
        color: Theme.of(context).appBarTheme.color,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              secondsToFormattedTime(currentProgram.totalTime),
            ),
            RaisedButton(
              onPressed: () {},
              color: Theme.of(context).splashColor,
              splashColor: Colors.grey[800],
              child: Text(
                'Play',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
