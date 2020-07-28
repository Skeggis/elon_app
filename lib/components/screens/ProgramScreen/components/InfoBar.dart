import 'package:flutter/cupertino.dart';
import 'package:myapp/services/helper.dart';
import 'package:myapp/services/models/DeviceModel.dart';
import 'package:myapp/services/models/Program.dart';

class ProgramInfoBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Program currentProgram =
        DeviceModel.of(context, rebuildOnChange: true).currentProgram;
    return Container(
      margin: EdgeInsets.only(bottom: 20, top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                currentProgram.sets.toString(),
                style: TextStyle(fontSize: 24),
              ),
              Text(
                'Sets',
                style: TextStyle(fontSize: 16),
              )
            ],
          ),
          Column(
            children: <Widget>[
              Text(
                secondsToMinutes(currentProgram.timeout),
                style: TextStyle(fontSize: 24),
              ),
              Text(
                'Between sets',
                style: TextStyle(fontSize: 16),
              )
            ],
          )
        ],
      ),
    );
  }
}
