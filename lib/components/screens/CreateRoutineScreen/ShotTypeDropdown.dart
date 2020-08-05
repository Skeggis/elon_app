import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:myapp/services/models/scopedModels/CreateRoutineModel.dart';

class ShotTypeDropdown extends StatefulWidget {
  final BuildContext myContext;
  final int locationId;
  ShotTypeDropdown(this.myContext, this.locationId);

  @override
  State<StatefulWidget> createState() {
    return _ShotTypeDropdown();
  }
}

class _ShotTypeDropdown extends State<ShotTypeDropdown> {
  int selected;

  @override
  void initState() {
    CreateRoutineModel model =  CreateRoutineModel.of(widget.myContext);
    selected = model
        .shotLocations
        .firstWhere((element) => element.id == widget.locationId)
        .shots[0]
        .id;
      
      model.selectedShotId = selected;
      
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: selected,
      onChanged: (value) {
        print(value);
        CreateRoutineModel.of(widget.myContext).setSelectedShot(value);
        setState(() {
          selected = value;
        });
      },
      items: CreateRoutineModel.of(widget.myContext)
          .shotLocations
          .firstWhere((element) => element.id == widget.locationId)
          .shots
          .map(
            (item) => DropdownMenuItem(
              child: Text(item.shotType.name),
              value: item.id,
            ),
          )
          .toList(),
    );
  }
}
