import 'package:flutter/material.dart';
import 'package:myapp/components/screens/CreateRoutineScreen/ShotTimeoutInput.dart';
import 'package:myapp/components/screens/CreateRoutineScreen/ShotTypeDropdown.dart';
import 'package:myapp/services/models/scopedModels/CreateRoutineModel.dart';

class CreateShotDialog extends StatelessWidget {
  final BuildContext myContext;
  final int locationId;
  CreateShotDialog(this.myContext, this.locationId);

  @override
  Widget build(BuildContext context) {
    Widget inputShotTimeout = ShotTimeoutInput(myContext);
    Widget chooseShotType = ShotTypeDropdown(myContext, locationId);

    return AlertDialog(
      title: Text('Create shot'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [chooseShotType, inputShotTimeout],
          )
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel', style: TextStyle(color: Colors.white)),
        ),
        RaisedButton(
          child: Text('Done'),
          onPressed: () {
            CreateRoutineModel.of(myContext).addCurrentShot(locationId);
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
