import 'package:flutter/material.dart';
import 'package:myapp/styles/theme.dart';
import 'package:myapp/components/screens/ConnectElonScreen/components/body.dart';

import 'package:flutter_blue/flutter_blue.dart';

class ConnectElonScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyTheme.barBackgroundColor,
        elevation: 0.0,
        title: Text('Elon'),
      ),
      backgroundColor: MyTheme.barBackgroundColor,
      body: StreamBuilder<BluetoothState>(
          stream: FlutterBlue.instance.state,
          builder: (context, snapshot) {
            final state = snapshot.data;
            return ConnectElonScreenBody(
              bluetoothAvailable: state == BluetoothState.on,
              state: state,
            );
          }),
    );
  }
}
