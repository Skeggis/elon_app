import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/components/screens/CreateRoutineScreen/arguments/CreateRoutineArguments.dart';
import 'package:myapp/components/screens/CreateRoutineScreen/body.dart';
import 'package:myapp/services/models/scopedModels/CreateRoutineModel.dart';
import 'package:myapp/services/models/scopedModels/ProgramsModel.dart';
import 'package:scoped_model/scoped_model.dart';

class CreateRoutineScreen extends StatelessWidget {
  static const String routeName = '/createRoutine';

  @override
  Widget build(BuildContext context) {
    final CreateRoutineArguments args =
        ModalRoute.of(context).settings.arguments;

    return ScopedModel<CreateRoutineModel>(
      model: CreateRoutineModel(args.shotLocations, args.shots),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text('Create routine'),
        ),
        body: CreateRoutineBody(),
      ),
    );
  }
}
