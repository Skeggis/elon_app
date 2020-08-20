import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/components/CustomInput/CustomInput.dart';
import 'package:myapp/components/CustomTimePicker/CustomTimePicker.dart';
import 'package:myapp/components/screens/ProgramScreen/components/RoutineDescription.dart';
import 'package:myapp/services/helper.dart';
import 'package:myapp/services/models/Program.dart';
import 'package:myapp/services/models/Routine.dart';
import 'package:myapp/services/models/scopedModels/CreateProgramModel.dart';
import 'package:myapp/services/models/scopedModels/ProgramModel.dart';

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

    String getPlayingRoundText() {
      ProgramModel model = ProgramModel.of(context, rebuildOnChange: true);
      if (index < model.currentRoutine) {
        return routine.rounds.toString();
      } else if (index == model.currentRoutine) {
        return (model.currentRoutineRound + 1).toString();
      } else {
        return '0';
      }
    }

    Widget leading = creating
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 40,
                    child: CustomInput(
                      initialText: routine.rounds.toString(),
                      onFocusLost: (controller) =>
                          CreateProgramModel.of(context)
                              .onRoundsFocusLost(controller, index),
                    ),
                  )
                ],
              ),
              Icon(
                Icons.clear,
                size: 20,
              )
            ],
          )
        : ProgramModel.of(context, rebuildOnChange: true).playing
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: getPlayingRoundText(),
                          style: TextStyle(fontSize: 24)),
                      TextSpan(
                          text: '/${routine.rounds}',
                          style: TextStyle(fontSize: 16))
                    ]),
                  ),
                  Text(
                    'Rounds',
                    style: TextStyle(fontSize: 12),
                  )
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    Text(
                      '${routine.rounds}',
                      style: TextStyle(fontSize: 24),
                    ),
                    Text(
                      'Rounds',
                      style: TextStyle(fontSize: 12),
                    )
                  ]);

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
        : Stack(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text:
                              '${secondsToMinutes(ProgramModel.of(context, rebuildOnChange: true).program.routines[index].displayTimeout)}',
                          style: TextStyle(fontSize: 24)),
                      TextSpan(text: ' rest', style: TextStyle(fontSize: 16))
                    ],
                  ),
                ),
              ),
              ProgramModel.of(context, rebuildOnChange: true).isRoutineResting(index)
                  ? Positioned(
                      top: 0,
                      right: 0,
                      child: Icon(
                        Icons.brightness_1,
                        size: 8,
                        color: Theme.of(context).accentColor,
                      ),
                    )
                  : SizedBox.shrink()
            ],
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
                    child: leading),
              ),
              Expanded(
                child: RoutineDescription(
                  creating: creating,
                  index: index,
                  routineDesc: routine.routineDesc,
                  scrollController: creating ? null : ProgramModel.of(context).scrollControllers[index],
                  handleDelete: creating
                      ? () =>
                          CreateProgramModel.of(context).removeRoutine(index)
                      : null,
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
