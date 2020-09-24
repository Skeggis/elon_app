import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/components/screens/ProgramScreen/arguments/ProgramScreenArguments.dart';
import 'package:myapp/components/screens/ProgramScreen/components/InfoBar.dart';
import 'package:myapp/components/screens/ProgramScreen/components/RoutinesList.dart';
import 'package:myapp/services/models/scopedModels/CreateProgramModel.dart';
import 'package:myapp/services/models/Program.dart';
import 'package:myapp/services/models/scopedModels/ProgramModel.dart';
import 'package:scoped_model/scoped_model.dart';

class ProgramScreenBody extends StatefulWidget {
  final ProgramScreenArguments args;

  ProgramScreenBody(this.args);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProgramScreenBody();
  }
}

class _ProgramScreenBody extends State<ProgramScreenBody> {
  Future testFuture;

  @override
  void initState() {
    testFuture = ProgramModel.of(context).fetchProgram(widget.args.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ProgramModel.of(context).fetchProgram(widget.args.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          ProgramModel model = ProgramModel.of(context, rebuildOnChange: true);
          Program program = model.program;

          return Stack(
            children: [
              Container(
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
              ),
              model.countdown
                  ? SizedBox.expand(
                      child: Container(
                        color: Color.fromARGB(200, 0, 0, 0),
                        child: Center(
                          child: Text(
                            model.countDownTime.toString(),
                            style: TextStyle(fontSize: 72),
                          ),
                        ),
                      ),
                    )
                  : SizedBox.shrink()
            ],
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
            rebuildOnChange: true,
            builder: (context, child, model) => Container(
              child: Column(
                children: <Widget>[
                  ProgramInfoBar(
                    program: model.program,
                  ),
                  RoutinesList(
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
