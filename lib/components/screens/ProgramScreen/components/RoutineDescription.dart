import 'package:flutter/cupertino.dart';
import 'package:myapp/components/screens/ProgramScreen/components/ShotDescription.dart';
import 'package:myapp/services/models/RoutineDesc.dart';

class RoutineDescription extends StatelessWidget {
  final List<RoutineDesc> routineDescs;

  RoutineDescription({this.routineDescs});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            padding: EdgeInsets.only(right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: routineDescs
                  .map((e) => ShotDescription(shot: e.shot, timeout: e.timeout))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
