import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/services/helper.dart';
import 'package:myapp/services/models/Shot.dart';
import 'dart:math' as math;

import 'package:myapp/services/models/scopedModels/ProgramModel.dart';

class ShotDescription extends StatelessWidget {
  final Shot shot;
  final bool creating;
  final int shotIndex;
  final int routineIndex;

  ShotDescription({
    this.shot,
    this.creating,
    this.shotIndex,
    this.routineIndex,
  });

  @override
  Widget build(BuildContext context) {
    bool highlight = creating
        ? false
        : ProgramModel.of(context, rebuildOnChange: true).playing &&
            ProgramModel.of(context, rebuildOnChange: true).currentRoutine ==
                routineIndex &&
            ProgramModel.of(context, rebuildOnChange: true).currentShot ==
                shotIndex;
    bool shotHighlight = !highlight
        ? false
        : ProgramModel.of(context, rebuildOnChange: true).shooting;
    bool restHighLight = !highlight
        ? false
        : !ProgramModel.of(context, rebuildOnChange: true).shooting;

    return Container(
      margin: EdgeInsets.only(left: 20, top: 8, bottom: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    shot.locationId == 5
                        ? Icon(Icons.radio_button_unchecked)
                        : Transform.rotate(
                            angle: angleForLocationId(shot.locationId) *
                                (math.pi / 180),
                            child: Icon(Icons.arrow_upward),
                          ),
                    Text(shot.shotType.name),
                  ],
                ),
              ),
              shotHighlight
                  ? Positioned(
                      top: 0,
                      right: 0,
                      child: Icon(
                        Icons.brightness_1,
                        size: 8,
                        color: Theme.of(context).accentColor,
                      ),
                    )
                  : SizedBox.shrink(),
            ],
          ),
          Container(
            // decoration: BoxDecoration(color: Colors.red),
            margin: EdgeInsets.only(left: 20),
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(8),
                  child: Text(secondsToMinutes(creating ? shot.timeout : shot.displayTimeout)),
                ),
                restHighLight
                    ? Positioned(

                        top: 0,
                        right: 0,
                        child: Icon(
                          Icons.brightness_1,
                          size: 8,
                          color: Theme.of(context).accentColor,
                        ),
                      )
                    : SizedBox.shrink(),
              ],
            ),
          )
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
