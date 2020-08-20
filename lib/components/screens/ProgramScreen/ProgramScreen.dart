import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/components/screens/ProgramScreen/arguments/ProgramScreenArguments.dart';
import 'package:myapp/components/screens/ProgramScreen/components/body.dart';
import 'package:myapp/services/models/scopedModels/ProgramModel.dart';
import 'package:myapp/services/models/scopedModels/ProgramsModel.dart';
import 'package:scoped_model/scoped_model.dart';

class ProgramScreen extends StatelessWidget {
  static const String routeName = '/program';

  @override
  Widget build(BuildContext context) {
    final ProgramScreenArguments args =
        ModalRoute.of(context).settings.arguments;
    ProgramModel model = ProgramModel();
    return ScopedModel<ProgramModel>(
      model: model,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(args.name),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              
              model.clearTimer();
              Navigator.pop(context);
            },
          ),
        ),
        body: ProgramScreenBody(args),
        floatingActionButton: Builder(
          builder: (context) =>
              ProgramModel.of(context, rebuildOnChange: true).playing
                  ? FloatingActionButton(
                      child: Icon(Icons.pause),
                      onPressed: () => ProgramModel.of(context).pause(),
                    )
                  : FloatingActionButton(
                      child: Icon(Icons.play_arrow),
                      onPressed: () => ProgramModel.of(context).play(context),
                    ),
        ),
      ),
    );
  }
}
