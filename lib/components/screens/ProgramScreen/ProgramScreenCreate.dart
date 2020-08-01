import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:myapp/components/screens/ProgramScreen/components/body.dart';
import 'package:myapp/services/models/DeviceModel.dart';
import 'package:myapp/services/models/ProgramsModel.dart';
import 'package:scoped_model/scoped_model.dart';

class ProgramScreenCreate extends StatelessWidget {
  static const String routeName = '/createProgram';

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ProgramsModel>(
      model: ProgramsModel(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Create Program'),
        ),
        body: ProgramScreenBodyCreate(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, '/createRoutine'),
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
