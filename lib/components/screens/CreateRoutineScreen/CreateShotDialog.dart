import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/components/CustomTimePicker/CustomTimePicker.dart';
import 'package:myapp/components/screens/CreateRoutineScreen/ShotTypeDropdown.dart';
import 'package:myapp/services/helper.dart';
import 'package:myapp/services/models/scopedModels/CreateRoutineModel.dart';
import 'package:myapp/services/models/scopedModels/ProgramsModel.dart';
import 'package:scoped_model/scoped_model.dart';

class CreateShotDialog extends StatefulWidget {
  final BuildContext myContext;
  final int locationId;
  CreateShotDialog(this.myContext, this.locationId);
  @override
  State<StatefulWidget> createState() {
    return _CreateShotDialog();
  }
}

class _CreateShotDialog extends State<CreateShotDialog> {
  int timeout;

  @override
  void initState() {
    super.initState();
    timeout = CreateRoutineModel.of(widget.myContext).currentShotTimeout;
  }

  @override
  Widget build(BuildContext context) {
    Future<void> shotTimeoutPicker(myContext) async {
      CreateRoutineModel model =
          CreateRoutineModel.of(myContext, rebuildOnChange: true);
      return showDialog(
        context: context,
        builder: (context) => CustomTimePicker(
          handleTimerDurationChange: (Duration duration) {
            int seconds = duration.inSeconds;
            model.setCurrentShotTimeout(seconds);
            setState(() {
              timeout = seconds;
            });
          },
          initialDuration: Duration(seconds: model.currentShotTimeout),
          timerMode: CupertinoTimerPickerMode.ms,
        ),
      );
    }

    Widget chooseShotType =
        ShotTypeDropdown(widget.myContext, widget.locationId);

    return AlertDialog(
      title: Text('Create shot'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                chooseShotType,
                RaisedButton(
                  elevation: 10,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  color: Theme.of(context).canvasColor,
                  onPressed: () => shotTimeoutPicker(widget.myContext),
                  child: Text(
                    secondsToFormattedTime(timeout),
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel', style: TextStyle(color: Colors.white)),
        ),
        RaisedButton(
          child: Text('Done'),
          onPressed: () {
            CreateRoutineModel.of(widget.myContext)
                .addCurrentShot(widget.locationId);
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
