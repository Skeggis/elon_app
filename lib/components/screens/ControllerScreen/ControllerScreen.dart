import 'package:flutter/material.dart';
import 'package:myapp/styles/theme.dart';
import 'package:myapp/components/screens/ControllerScreen/components/body.dart';
import 'package:myapp/services/models/DeviceModel.dart';

class ControllerScreen extends StatelessWidget {
  static const String routeName = '/controller';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyTheme.barBackgroundColor,
        elevation: 0.0,
        title: Text('Elon'),
        actions: [
          Padding(
              child: IconButton(
                icon: Icon(Icons.pause, size: 30.0),
                onPressed: () {
                  DeviceModel.of(context).flipStart();
                },
              ),
              padding: EdgeInsets.only(right: 25.0))
        ],
      ),
      backgroundColor: MyTheme.backgroundColor,
      body: ControllerScreenBody(),
    );
  }
}
