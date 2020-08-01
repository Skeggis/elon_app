import 'package:flutter/cupertino.dart';
import 'package:myapp/components/screens/ProgramScreen/components/RoutineListItem.dart';
import 'package:myapp/services/models/DeviceModel.dart';
import 'package:myapp/services/models/Program.dart';

class RoutinesList extends StatelessWidget {
  final bool creating;
  final Program program;

  RoutinesList({this.creating = false, this.program});

  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: program.routines.length == 0
          ? Center(
              child: Text('Add a routine', style: TextStyle(fontSize: 18),),
            )
          : Container(
              child: ListView(
              children: program.routines
                  .asMap()
                  .map(
                    (index, routine) => MapEntry(
                      index,
                      Container(
                        margin: EdgeInsets.only(
                            left: 20, top: 10, right: 10, bottom: 10),
                        child: RoutineListItem(
                          routine: program.routines[index],
                          index: index,
                        ),
                      ),
                    ),
                  )
                  .values
                  .toList(),
            )),
    );
  }
}
