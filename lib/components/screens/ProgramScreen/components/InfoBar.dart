import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/components/CustomInput/CustomInput.dart';
import 'package:myapp/components/CustomTimePicker/CustomTimePicker.dart';
import 'package:myapp/services/helper.dart';
import 'package:myapp/services/models/scopedModels/CreateProgramModel.dart';
import 'package:myapp/services/models/Program.dart';
import 'package:myapp/services/models/scopedModels/DeviceModel.dart';
import 'package:myapp/services/models/scopedModels/ProgramModel.dart';
import 'package:myapp/styles/theme.dart';
import 'package:scoped_model/scoped_model.dart';

class ProgramInfoBar extends StatelessWidget {
  final Program program;

  ProgramInfoBar({
    this.program,
  });

  @override
  Widget build(BuildContext context) {
    bool creating = !DeviceModel.of(context).viewingProgram;
    Widget sets = creating
        ? SizedBox(
            width: 50,
            height: 50,
            child: CustomInput(
              initialText:
                  CreateProgramModel.of(context).program.sets.toString(),
              onFocusLost: (controller) =>
                  CreateProgramModel.of(context).onSetsFocusLost(controller),
            ),
          )
        : ScopedModelDescendant<ProgramModel>(
            rebuildOnChange: true,
            builder: (context, child, model) => model.playing
                ? RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: '${model.currentSet + 1}',
                          style: TextStyle(fontSize: 24)),
                      TextSpan(
                          text: '/${program.sets}',
                          style: TextStyle(fontSize: 16))
                    ]),
                  )
                : Text(
                    program.sets.toString(),
                    style: TextStyle(fontSize: 24),
                  ),
          );

    Future<void> showTimeDialog(BuildContext myContext) async {
      await showDialog(
        context: context,
        builder: (context) => CustomTimePicker(
          timerMode: CupertinoTimerPickerMode.ms,
          handleTimerDurationChange: (Duration duration) =>
              CreateProgramModel.of(myContext)
                  .setSetsTimeout(duration.inSeconds),
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
        : Stack(
            children: [
              Container(
                padding: EdgeInsets.only(right: 8, left: 8, top: 8),
                child: Text(
                  secondsToMinutes(
                      ProgramModel.of(context, rebuildOnChange: true)
                          .program
                          .displayTimeout),
                  style: TextStyle(fontSize: 24),
                ),
              ),
              ProgramModel.of(context, rebuildOnChange: true).setResting
                  ? Positioned(
                      top: 0,
                      right: 0,
                      child: Icon(
                        Icons.brightness_1,
                        color: Theme.of(context).accentColor,
                        size: 8,
                      ),
                    )
                  : SizedBox.shrink()
            ],
          );

    return Material(
      elevation: 12,
      color: Theme.of(context).appBarTheme.color,
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
