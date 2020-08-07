import 'package:flutter/material.dart';
import 'package:myapp/components/screens/ProgramScreen/ProgramScreen.dart';
import 'package:myapp/components/screens/ProgramScreen/arguments/ProgramScreenArguments.dart';
import 'package:myapp/components/screens/ProgramsScreen/components/ProgramListItem/ProgramListItem.dart';
import 'package:myapp/services/models/Program.dart';
import 'package:myapp/services/models/scopedModels/ProgramsModel.dart';

class ProgramsScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future fetchPrograms = ProgramsModel.of(context).fetchPrograms();

    return RefreshIndicator(
      
      color: Theme.of(context).splashColor,
      onRefresh: () {
        return ProgramsModel.of(context).fetchPrograms();
      },
      child: Container(
        child: FutureBuilder(
          future: fetchPrograms,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              List<Program> programs =
                  ProgramsModel.of(context, rebuildOnChange: true).programs;
              if (programs == null || programs.length == 0) {
                return Center(
                  child: Text(
                    'No programs found',
                  ),
                );
              } else {
                return ListView.builder(
                    itemCount: programs.length,
                    itemBuilder: (context, index) {
                      Program program = programs[index];
                      return ProgramListItem(index: index, program: program);
                    });
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
