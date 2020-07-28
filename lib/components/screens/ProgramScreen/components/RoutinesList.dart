import 'package:flutter/cupertino.dart';
import 'package:myapp/components/screens/ProgramScreen/components/RoutineListItem.dart';
import 'package:myapp/services/models/DeviceModel.dart';
import 'package:myapp/services/models/Program.dart';

class RoutinesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Program currentProgram =
        DeviceModel.of(context, rebuildOnChange: true).currentProgram;
    return Expanded(
      child: Container(
        child: ListView.builder(
          itemCount: currentProgram.routines.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(left: 20, top: 10, right: 10, bottom: 10),
              child: RoutineListItem(
                routine: currentProgram.routines[index],
                index: index,
              ),
            );
          },
        ),
      ),
    );
  }
}
