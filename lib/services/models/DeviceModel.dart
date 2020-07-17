import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_blue/flutter_blue.dart';

import 'dart:convert';

class DeviceModel extends Model {
  BluetoothDevice _elon;
  List<BluetoothService> _elonServices = [];
  //Balls per minute
  int _bpm = 0;
  int get bpm => _bpm;

  void changeBPM(int add) {
    _bpm += add;
    if (_bpm < 0) _bpm = 0;
    if (_bpm > 60) _bpm = 60;
    notifyListeners();
  }

  BluetoothDevice get elon => _elon;
  StreamSubscription<BluetoothDeviceState> _elonStateStream;
  void connect(BluetoothDevice device) {
    print("HERE");
    if (_elonStateStream != null) _elonStateStream.cancel();
    _elonStateStream = device.state.listen((event) async {
      if (event == BluetoothDeviceState.disconnected ||
          event == BluetoothDeviceState.disconnecting) {
        // _elonStateStream.cancel();
        _elon = null;
        _elonServices = [];
        notifyListeners();
      } else if (event == BluetoothDeviceState.connected) {
        _elon = device;
        _elonServices = await _elon.discoverServices();
        print(_elonServices.length);
        print(_elonServices[0]);
        _elonServices.map((s) => print('Matur'));
        notifyListeners();
      }
    });

    device.connect();
  }

  void checkIfAlreadyConnected() async {
    if (_elon != null) return;
    var devi =
        await Stream.fromFuture(FlutterBlue.instance.connectedDevices).first;
    _elon = devi[0];
    notifyListeners();
  }

//Todo: Now the command writes to ALL characteristics of the connected device. Only send to the one with the correct id?
  void sendCommand(String command) async {
    if (_elon == null) return;
    if (_elonServices.length == 0)
      _elonServices = await _elon.discoverServices();

    // _elonServices[0].characteristics[0].descriptors[0].
    _elonServices.map((s) => print(s.characteristics));
    print('Sending');
    _elonServices[0]
        .characteristics[0]
        .write([126, 125], withoutResponse: true);
    // .write(utf8.encode(command), withoutResponse: true);
  }

  static DeviceModel of(BuildContext context) =>
      ScopedModel.of<DeviceModel>(context);
}
