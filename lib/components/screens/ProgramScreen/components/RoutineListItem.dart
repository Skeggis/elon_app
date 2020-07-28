import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/components/screens/ProgramScreen/components/RoutineDescription.dart';
import 'package:myapp/services/helper.dart';
import 'package:myapp/services/models/Routine.dart';

class RoutineListItem extends StatelessWidget {
  final Routine routine;
  final int index;

  RoutineListItem({this.routine, this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      '${routine.rounds}',
                      style: TextStyle(fontSize: 24),
                    ),
                    Icon(
                      Icons.clear,
                      size: 20,
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Material(
                  elevation: 12,
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(4),
                  child: RoutineDescription(routineDescs: routine.routineDescs),
                ),
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Text(secondsToMinutes(routine.timeout)),
        )
      ],
    );
  }
}
