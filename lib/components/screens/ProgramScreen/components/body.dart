import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/components/screens/ProgramScreen/arguments/ProgramScreenArguments.dart';
import 'package:myapp/components/screens/ProgramScreen/components/InfoBar.dart';
import 'package:myapp/components/screens/ProgramScreen/components/RoutinesList.dart';
import 'package:myapp/services/models/DeviceModel.dart';

class ProgramScreenBody extends StatelessWidget {
  final ProgramScreenArguments args;

  ProgramScreenBody(this.args);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DeviceModel.of(context).fetchProgram(args.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Container(
            child: Column(
              children: [
                ProgramInfoBar(),
                RoutinesList(),
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
    return Container(
        child: Column(
      children: <Widget>[
        ProgramInfoBar(creating: true),
        RoutinesList(creating: true)
      ],
    ));
  }
}
