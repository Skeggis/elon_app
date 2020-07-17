import 'package:flutter/material.dart';
import 'package:myapp/components/CustomButton/CustomButton.dart';
import 'package:myapp/services/helpers.dart';

import 'package:myapp/services/models/DeviceModel.dart';

import 'package:flutter_blue/flutter_blue.dart';
import 'dart:async';

class ConnectElonScreenBody extends StatelessWidget {
  bool bluetoothAvailable;
  BluetoothState state;

  ConnectElonScreenBody({this.bluetoothAvailable, this.state}) {
    FlutterBlue.instance.startScan(timeout: Duration(seconds: 4));
  }

  Widget _deviceRow(BluetoothDevice device) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(device.name),
          SizedBox(
            width: 20.0,
          ),
          StreamBuilder<BluetoothDeviceState>(
              stream: device.state,
              initialData: BluetoothDeviceState.disconnected,
              builder: (context, snapshot) {
                return CustomButton(
                  onPressed: () => {
                    if (snapshot.data == BluetoothDeviceState.connected)
                      device.disconnect()
                    else
                      DeviceModel.of(context).connect(device)
                    // device.connect()
                  },
                  title: snapshot.data == BluetoothDeviceState.connected
                      ? 'Disconnect'
                      : 'Connect',
                  isSelected: snapshot.data == BluetoothDeviceState.connected,
                  size: Size(140.0, 45.0),
                );
              })
        ],
      ),
    );
  }

  Widget _bottom(context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Center(
              child: Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 35.0),
            child: Text('Leita að skjótara',
                style: Theme.of(context).textTheme.bodyText2),
          )),
          IconTheme(
            data: Theme.of(context).iconTheme,
            child: Icon(Icons.bluetooth_searching, size: 50.0),
          )
        ],
      ),
    ]);
  }

  Widget _searchDone() {
    return StreamBuilder<List<BluetoothDevice>>(
      stream: Stream.periodic(Duration(milliseconds: 500))
          .asyncMap((event) => FlutterBlue.instance.connectedDevices),
      initialData: [],
      builder: (context, snapshot) => DeviceModel.of(context).elon != null
          ? Padding(
              padding: EdgeInsets.fromLTRB(25.0, 0, 25.0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    onPressed: () => FlutterBlue.instance
                        .startScan(timeout: Duration(seconds: 4)),
                    title: 'Search',
                    isSelected: true,
                    icon: Icon(Icons.bluetooth_searching, size: 30.0),
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  ),
                  CustomButton(
                    onPressed: () =>
                        Navigator.pushReplacementNamed(context, '/elon'),
                    title: 'Shoot',
                    isSelected: true,
                    icon: Icon(Icons.label_important, size: 30.0),
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  ),
                ],
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  onPressed: () => FlutterBlue.instance
                      .startScan(timeout: Duration(seconds: 4)),
                  title: 'Search for device',
                  isSelected: true,
                  icon: Icon(Icons.bluetooth_searching, size: 30.0),
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                )
              ],
            ),
    );
  }

  Widget _bluetooth(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: screenHeight(context) * 0.6,
          child: Padding(
            padding: EdgeInsets.only(top: 25.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  StreamBuilder<List<BluetoothDevice>>(
                    stream: Stream.periodic(Duration(seconds: 2))
                        .asyncMap((_) => FlutterBlue.instance.connectedDevices),
                    initialData: [],
                    builder: (c, snapshot1) {
                      return StreamBuilder<List<ScanResult>>(
                          stream: FlutterBlue.instance.scanResults,
                          initialData: [],
                          builder: (c, snapshot2) {
                            var filtered = snapshot2.data.where((r) =>
                                r.device.name != '' &&
                                !snapshot1.data.contains(r.device));
                            return Column(children: [
                              ...snapshot1.data
                                  .map((d) => _deviceRow(d))
                                  .toList(),
                              ...filtered
                                  .map((r) => _deviceRow(r.device))
                                  .toList(),
                            ]);
                          });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: StreamBuilder<bool>(
            stream: FlutterBlue.instance.isScanning,
            initialData: false,
            builder: (context, snapshot) =>
                snapshot.data ? _bottom(context) : _searchDone(),
          ),
        )
      ],
    );
  }

  Widget _noBluetooth(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
            child: Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 50.0),
          child: Text(
              'Bluetooth Adapter is ${state != null ? state.toString().substring(15) : 'not available'}.',
              style: Theme.of(context).textTheme.bodyText2),
        )),
        IconTheme(
          data: Theme.of(context).iconTheme,
          child: Icon(Icons.bluetooth_disabled, size: 50.0),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    DeviceModel.of(context).checkIfAlreadyConnected();
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.fromLTRB(
            0.0, 0.0, 0.0, screenHeight(context, dividedBy: 12.5)),
        child: bluetoothAvailable ? _bluetooth(context) : _noBluetooth(context),
      ),
    );
  }
}
