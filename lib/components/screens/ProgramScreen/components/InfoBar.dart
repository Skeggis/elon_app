import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:myapp/components/CustomInput/CustomInput.dart';
import 'package:myapp/components/CustomTimePicker/CustomTimePicker.dart';
import 'package:myapp/services/helper.dart';
import 'package:myapp/services/models/scopedModels/CreateProgramModel.dart';
import 'package:myapp/services/models/scopedModels/DeviceModel.dart';
import 'package:myapp/services/models/Program.dart';
import 'package:myapp/services/models/scopedModels/ProgramsModel.dart';
import 'package:myapp/styles/theme.dart';

class ProgramInfoBar extends StatelessWidget {
  final bool creating;
  final Program program;

  ProgramInfoBar({this.creating = false, this.program});

  @override
  Widget build(BuildContext context) {
  

    Widget sets = creating
        ? SizedBox(
            width: 50,
            height: 50,
            child: CustomInput(
              initialText: CreateProgramModel.of(context).program.sets.toString(),
              onFocusLost: (controller) => CreateProgramModel.of(context).onSetsFocusLost(controller),
            ),
          )
        : Text(
            program.sets.toString(),
            style: TextStyle(fontSize: 24),
          );

    Future<void> showTimeDialog(BuildContext myContext) async {
      await showDialog(
        context: context,
        builder: (context) => CustomTimePicker(
          timerMode: CupertinoTimerPickerMode.ms,
          handleTimerDurationChange: (Duration duration) =>
              CreateProgramModel.of(myContext).setSetsTimeout(duration.inSeconds),
          initialDuration: Duration(seconds: program.timeout),
        ),
      );
    }

    Widget setTimeout = creating
        ? FlatButton(
            onPressed: () => showTimeDialog(context),
            child: Text(
              secondsToFormattedTime(program.timeout),
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          )
        : Text(
            secondsToMinutes(program.timeout),
            style: TextStyle(fontSize: 24),
          );

    return Material(
      elevation: 12,
      color: MyTheme.backgroundColor,
      child: Container(
        padding: EdgeInsets.only(bottom: 20, top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                sets,
                Text(
                  'Sets',
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),
            Column(
              children: <Widget>[
                setTimeout,
                Text(
                  'Between sets',
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
