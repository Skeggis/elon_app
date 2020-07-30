import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/components/screens/CreateRoutineScreen/body.dart';

class CreateRoutineScreen extends StatelessWidget {
  static const String routeName = '/createRoutine';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Routine'),
      ),
      body: CreateRoutineBody(),
    );
  }
}
