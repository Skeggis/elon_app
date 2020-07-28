import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/services/models/Shot.dart';

class ShotDescription extends StatelessWidget {
  final Shot shot;
  final int timeout;

  ShotDescription({this.shot, this.timeout});

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
              Icon(Icons.crop_square),
              Text(shot.name),
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Text('${timeout}s'),
          ),
        ],
      ),
    );
  }
}
