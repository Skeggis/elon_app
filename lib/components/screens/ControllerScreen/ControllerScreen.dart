import 'package:flutter/material.dart';
import 'package:myapp/styles/theme.dart';
import 'package:myapp/components/screens/ControllerScreen/components/body.dart';
import 'package:myapp/services/models/scopedModels/DeviceModel.dart';

class ControllerScreen extends StatelessWidget {
  static const String routeName = '/controller';
  @override
  Widget build(BuildContext context) {
    bool start = DeviceModel.of(context, rebuildOnChange: true).start;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Elon'),
        actions: [
          start
              ? Padding(
                  child: IconButton(
                    icon: Icon(Icons.pause, size: 30.0),
                    onPressed: () {
                      DeviceModel.of(context).flipStart();
                    },
                  ),
                  padding: EdgeInsets.only(right: 25.0))
              : SizedBox(width: 5),
        ],
      ),
      body: ControllerScreenBody(),
    );
  }
}
