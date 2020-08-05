import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/components/screens/ProgramScreen/arguments/ProgramScreenArguments.dart';
import 'package:myapp/components/screens/ProgramScreen/components/InfoBar.dart';
import 'package:myapp/components/screens/ProgramScreen/components/RoutinesList.dart';
import 'package:myapp/services/models/scopedModels/CreateProgramModel.dart';
import 'package:myapp/services/models/scopedModels/DeviceModel.dart';
import 'package:myapp/services/models/Program.dart';
import 'package:myapp/services/models/scopedModels/ProgramsModel.dart';
import 'package:scoped_model/scoped_model.dart';

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
    return FutureBuilder(
      future: CreateProgramModel.of(context).fetchShots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ScopedModelDescendant<CreateProgramModel>(
            builder: (context, child, model) => Container(
              child: Column(
                children: <Widget>[
                  ProgramInfoBar(
                    creating: true,
                    program: model.program,
                  ),
                  RoutinesList(
                    creating: true,
                    program: model.program,
                  )
                ],
              ),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
