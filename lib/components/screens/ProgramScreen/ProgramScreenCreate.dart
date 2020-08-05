import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:myapp/components/screens/CreateRoutineScreen/arguments/CreateRoutineArguments.dart';
import 'package:myapp/components/screens/ProgramScreen/components/body.dart';
import 'package:myapp/components/screens/ProgramsScreen/ProgramsScreen.dart';
import 'package:myapp/routes/router.dart';
import 'package:myapp/services/models/Routine.dart';
import 'package:myapp/services/models/scopedModels/CreateProgramModel.dart';
import 'package:myapp/services/models/scopedModels/DeviceModel.dart';
import 'package:myapp/services/models/scopedModels/ProgramsModel.dart';
import 'package:scoped_model/scoped_model.dart';

class ProgramScreenCreate extends StatelessWidget {
  static const String routeName = '/createProgram';

  @override
  Widget build(BuildContext context) {
    final CreateProgramModel myModel = CreateProgramModel();

    Future<void> createFinalDialog(CreateProgramModel model, myContext) {
      return showDialog(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: Text('Insert information'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                onChanged: (value) => model.setName(value),
                decoration: InputDecoration.collapsed(
                  hintText: 'Name',
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                onChanged: (value) => model.setDescription(value),
                decoration: InputDecoration.collapsed(
                    hintText: 'Description',
                    hintStyle: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 10)
            ],
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: model.createProgramLoading
                  ? null
                  : () {
                      model.setName('');
                      model.setDescription('');
                      Navigator.pop(dialogContext);
                    },
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.white),
              ),
            ),
            RaisedButton(
              onPressed: model.createProgramLoading
                  ? null
                  : () async {
                      Navigator.pop(dialogContext);
                      await model.createProgram();
                      Navigator.pop(myContext);
                    },
              child: Text('Save'),
            )
          ],
        ),
      );
    }

    return ScopedModel<CreateProgramModel>(
      model: myModel,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          title: Text('Create Program'),
        ),
        body: ProgramScreenBodyCreate(),
        floatingActionButton: ScopedModelDescendant<CreateProgramModel>(
          builder: (scopedContext, child, model) =>
              model.program.routines.length == 0
                  ? FloatingActionButton(
                      onPressed: () async {
                        var createdRoutine = await Navigator.pushNamed(
                          context,
                          '/createRoutine',
                          arguments:
                              CreateRoutineArguments(model.shotLocations),
                        );
                        model.addRoutine(createdRoutine);
                      },
                      child: Icon(Icons.add),
                      heroTag: null,
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        FloatingActionButton(
                          onPressed: () async {
                            await createFinalDialog(model, scopedContext);
                          },
                          child: model.createProgramLoading
                              ? CircularProgressIndicator()
                              : Icon(Icons.save),
                          heroTag: null,
                        ),
                        SizedBox(height: 10),
                        FloatingActionButton(
                          onPressed: () async {
                            var createdRoutine = await Navigator.pushNamed(
                              context,
                              '/createRoutine',
                              arguments:
                                  CreateRoutineArguments(model.shotLocations),
                            );
                            model.addRoutine(createdRoutine);
                          },
                          child: Icon(Icons.add),
                          heroTag: null,
                        )
                      ],
                    ),
        ),
      ),
    );
  }
}
