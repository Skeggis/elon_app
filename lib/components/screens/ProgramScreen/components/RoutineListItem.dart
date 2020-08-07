import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/components/CustomInput/CustomInput.dart';
import 'package:myapp/components/CustomTimePicker/CustomTimePicker.dart';
import 'package:myapp/components/screens/ProgramScreen/components/RoutineDescription.dart';
import 'package:myapp/services/helper.dart';
import 'package:myapp/services/models/Routine.dart';
import 'package:myapp/services/models/scopedModels/CreateProgramModel.dart';

class RoutineListItem extends StatelessWidget {
  final Routine routine;
  final int index;
  final bool creating;

  RoutineListItem({
    this.routine,
    this.index,
    this.creating = false,
  });

  @override
  Widget build(BuildContext context) {
    
    Future<void> showTimeoutDialog(BuildContext myContext) {
      return showDialog(
        context: context,
        builder: (context) {
          return CustomTimePicker(
            handleTimerDurationChange: (Duration duration) =>
                CreateProgramModel.of(myContext)
                    .setRoutineTimeout(duration, index),
            initialDuration: Duration(seconds: routine.timeout),
            timerMode: CupertinoTimerPickerMode.ms,
          );
        },
      );
    }

    Widget numRounds = creating
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 40,
                child: CustomInput(
                  initialText: routine.rounds.toString(),
                  onFocusLost: (controller) => CreateProgramModel.of(context)
                      .onRoundsFocusLost(controller, index),
                ),
              )
            ],
          )
        : Text(
            '${routine.rounds}',
            style: TextStyle(fontSize: 24),
          );

    Widget roundTimeout = creating
        ? Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                FlatButton(
                  onPressed: () => showTimeoutDialog(context),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: secondsToFormattedTime(routine.timeout),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.normal),
                        ),
                        TextSpan(
                          text: '  rest',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ])
        : RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text: '${secondsToMinutes(routine.timeout)}',
                    style: TextStyle(fontSize: 24)),
                TextSpan(text: ' rest', style: TextStyle(fontSize: 16))
              ],
            ),
          );

    return Container(
      margin: EdgeInsets.only(top: index == 0 ? 20 : 0),
      child: Column(
        children: [
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 10),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 50,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      numRounds,
                      Icon(
                        Icons.clear,
                        size: 20,
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: RoutineDescription(routineDesc: routine.routineDesc, 
                  handleDelete: creating ? () => CreateProgramModel.of(context).removeRoutine(index) : null,
                ),
              ),
            ],
          ),
          Container(margin: EdgeInsets.only(top: 20), child: roundTimeout),
        ],
      ),
    );
  }
}
