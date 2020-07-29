import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/services/helper.dart';
import 'package:myapp/services/models/Shot.dart';
import 'dart:math' as math;

class ShotDescription extends StatelessWidget {
  final Shot shot;

  ShotDescription({this.shot});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, top: 15, bottom: 15),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              shot.locationId == 5
                  ? Icon(Icons.adjust)
                  : Transform.rotate(
                      angle:
                          angleForLocationId(shot.locationId) * (math.pi / 180),
                      child: Icon(Icons.arrow_upward),
                    ),
              Text(shot.typeName),
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Text(secondsToMinutes(shot.timeout)),
          ),
        ],
      ),
    );
  }

  double angleForLocationId(int id) {
    switch (id) {
      case 1:
        return -45;
        break;
      case 2:
        return 0;
        break;
      case 3:
        return 45;
      case 4:
        return -90;
        break;
      case 5:
        return 0;
        break;
      case 6:
        return 90;
        break;
      case 7:
        return -135;
        break;
      case 8:
        return 180;
        break;
      case 9:
        return 135;
        break;
      default:
        return 0;
        break;
    }
  }
}
