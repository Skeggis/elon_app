import 'package:flutter/material.dart';
import 'package:myapp/styles/theme.dart';
import 'package:myapp/components/screens/ConnectElonScreen/components/body.dart';

import 'package:flutter_blue/flutter_blue.dart';
import 'package:myapp/components/AppDrawer/AppDrawer.dart';

class ConnectElonScreen extends StatelessWidget {
  static const String routeName = 'BLE';
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: MyTheme.barBackgroundColor),
      child: StreamBuilder<BluetoothState>(
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
