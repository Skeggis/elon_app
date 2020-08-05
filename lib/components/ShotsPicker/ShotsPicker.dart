import 'package:flutter/material.dart';
import 'package:myapp/styles/theme.dart';

import 'package:myapp/services/models/Enums.dart';
import 'package:myapp/components/ShotsPicker/components/ShotType.dart';

import 'package:myapp/services/models/scopedModels/DeviceModel.dart';

class ShotsPicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ShotType shotType = DeviceModel.of(context, rebuildOnChange: true).shotType;

    return Container(
      padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
      margin: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
          color: MyTheme.backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SizedBox(width: 13),
            for (ShotType type in ShotType.values) ...[
              ShotTypeWidget(
                type: type,
                picked: type == shotType,
                onClick: () => DeviceModel.of(context).changeShotType(type),
              ),
              SizedBox(width: 10)
            ]
          ],
        ),
      ),
    );
  }
}
