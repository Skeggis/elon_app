import 'package:flutter/material.dart';
import 'package:myapp/components/screens/ProgramsScreen/components/ProgramListItem/ProgramListItem.dart';
import 'package:myapp/services/models/DeviceModel.dart';

class ProgramsScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DeviceModel.of(context).fetchPrograms(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Container(
            padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
            child: ListView(
              children: DeviceModel.of(context, rebuildOnChange: true)
                  .programs
                  .map((program) => ProgramListItem(
                        name: program.name,
                        description: program.description,
                        author: program.author,
                        numShots: program.numShots,
                        totalTime: program.totalTime,
                      ))
                  .toList(),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
