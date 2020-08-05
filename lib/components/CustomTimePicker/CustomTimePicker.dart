import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTimePicker extends StatelessWidget {
  final CupertinoTimerPickerMode timerMode;
  final Function handleTimerDurationChange;
  final Duration initialDuration;

  CustomTimePicker({
    this.timerMode,
    this.handleTimerDurationChange,
    this.initialDuration,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Insert time'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CupertinoTheme(
            data: Theme.of(context).cupertinoOverrideTheme,
            child: CupertinoTimerPicker(
              mode: timerMode,
              onTimerDurationChanged: (Duration duration) =>
                  handleTimerDurationChange(duration),
              initialTimerDuration: initialDuration,
            ),
          ),
        ],
      ),
      actions: <Widget>[
        RaisedButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Done'),
        )
      ],
    );
  }
}
