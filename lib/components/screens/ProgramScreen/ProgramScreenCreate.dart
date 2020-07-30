import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:myapp/components/screens/ProgramScreen/components/body.dart';
import 'package:myapp/services/models/DeviceModel.dart';

class ProgramScreenCreate extends StatelessWidget {
  static const String routeName = '/createProgram';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Create Program'),
      ),
      body: ProgramScreenBodyCreate(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/createRoutine'),
        child: Icon(Icons.add),
      ),
    );
  }
}
