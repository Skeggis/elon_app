import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/components/screens/ProgramScreen/arguments/ProgramScreenArguments.dart';
import 'package:myapp/components/screens/ProgramScreen/components/InfoBar.dart';
import 'package:myapp/components/screens/ProgramScreen/components/RoutinesList.dart';
import 'package:myapp/services/models/DeviceModel.dart';
import 'package:myapp/services/models/Program.dart';
import 'package:myapp/services/models/ProgramsModel.dart';

class ProgramScreenBody extends StatelessWidget {
  final ProgramScreenArguments args;

  ProgramScreenBody(this.args);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ProgramsModel.of(context).fetchProgram(args.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Program program = ProgramsModel.of(context).currentProgram;

          return Container(
            child: Column(
              children: [
                ProgramInfoBar(
                  program: program,
                ),
                RoutinesList(
                  program: program,
                ),
              ],
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class ProgramScreenBodyCreate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Program program = ProgramsModel.of(context, rebuildOnChange: true).createProgram;
    return Container(
        child: Column(
      children: <Widget>[
        ProgramInfoBar(
          creating: true,
          program: program,
        ),
        RoutinesList(
          creating: true,
          program: program,
        )
      ],
    ));
  }
}
