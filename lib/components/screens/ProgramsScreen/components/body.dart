import 'package:flutter/material.dart';
import 'package:myapp/components/screens/ProgramScreen/ProgramScreen.dart';
import 'package:myapp/components/screens/ProgramScreen/arguments/ProgramScreenArguments.dart';
import 'package:myapp/components/screens/ProgramsScreen/components/ProgramListItem/ProgramListItem.dart';
import 'package:myapp/services/models/DeviceModel.dart';
import 'package:myapp/services/models/Program.dart';

class ProgramsScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DeviceModel.of(context).fetchPrograms(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          List<Program> programs =
              DeviceModel.of(context, rebuildOnChange: true).programs;
          if (programs == null || programs.length == 0) {
            return Center(
              child: Text(
                'No programs found',
              ),
            );
          } else {
            return RefreshIndicator(
              color: Theme.of(context).splashColor,
              onRefresh: DeviceModel.of(context).fetchPrograms,
              child: Container(
                child: ListView.builder(
                    itemCount: programs.length,
                    itemBuilder: (context, index) {
                      Program program = programs[index];
                      return ProgramListItem(index: index, program: program);
                    }),
              ),
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
