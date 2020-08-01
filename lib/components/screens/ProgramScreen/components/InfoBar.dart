import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:myapp/services/helper.dart';
import 'package:myapp/services/models/DeviceModel.dart';
import 'package:myapp/services/models/Program.dart';
import 'package:myapp/services/models/ProgramsModel.dart';
import 'package:myapp/styles/theme.dart';

class ProgramInfoBar extends StatelessWidget {
  final bool creating;
  final Program program;

  ProgramInfoBar({this.creating = false, this.program});

  @override
  Widget build(BuildContext context) {
    Function setSetsTimeout = ProgramsModel.of(context).setSetsTimeout;

    Widget sets = creating
        ? SetInputField()
        : Text(
            program.sets.toString(),
            style: TextStyle(fontSize: 24),
          );

    Future<void> showTimeDialog() async {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Insert time'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CupertinoTheme(
                data: Theme.of(context).cupertinoOverrideTheme,
                child: CupertinoTimerPicker(
                  mode: CupertinoTimerPickerMode.ms,
                  onTimerDurationChanged: (Duration duration) {
                    setSetsTimeout(duration.inSeconds);
                  },
                  initialTimerDuration: Duration(seconds: program.timeout),
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
        ),
      );
    }

    Widget setTimeout = creating
        ? FlatButton(
            onPressed: () => showTimeDialog(),
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
        padding: EdgeInsets.only(bottom: 20, top: 30),
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

class SetInputField extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SetInputField();
  }
}

class _SetInputField extends State<SetInputField> {
  final _focusNode = FocusNode();
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Program program = ProgramsModel.of(context).createProgram;

    textController.text = program.sets.toString();

    _focusNode.addListener(() {
      print('her');
      print(_focusNode.hasFocus);
      if (!_focusNode.hasFocus) {
        if (textController.text != '') {
          program.sets = int.parse(textController.text);
        } else {
          program.sets = 1;
          textController.text = '1';
        }
      }
    });
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 50,
      child: TextFormField(
        controller: textController,
        focusNode: _focusNode,
        decoration: InputDecoration(
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: MyTheme.secondaryColor))),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
        ),
      ),
    );
  }
}
