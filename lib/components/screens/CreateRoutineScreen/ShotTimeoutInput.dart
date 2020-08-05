import 'package:flutter/material.dart';
import 'package:myapp/services/models/scopedModels/CreateRoutineModel.dart';

class ShotTimeoutInput extends StatelessWidget {
  final BuildContext myContext;
  ShotTimeoutInput(this.myContext);




  @override
  Widget build(BuildContext context) {
    CreateRoutineModel model = CreateRoutineModel.of(myContext);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(
          width: 30,
          height: 32,
          child: TextField(
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(bottom: 10),
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFBDBDBD),
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFBDBDBD),
                ),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFBDBDBD),
                ),
              ),
            ),
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
            controller: model.timeoutController,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text('s'),
      ],
    );
  }
}
