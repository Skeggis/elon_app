import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_blue/flutter_blue.dart';

import 'dart:convert';

enum ShotType { serve, clear, smash, drive, drop }

class Shot {
  int _maxLeftRight = 100;
  int _maxUpDown = 100;
  int _maxMotorSpeed = 100;

  int _amountOfLocationsPerRow = 3;
  int _amountOfLocationsPerColumn = 3;

  int leftRight; //0-100
  int upDown; //0-100
  int motorSpeed; //0-100
  int delay; //in milliseconds

  int bpm; //Balls per minute
  int location;
  ShotType type;

  /// location: 0 - (_amountOfLocationsPerRow*_amountofLocationsPerColumn - 1)
  Shot({@required this.type, @required this.location, @required this.bpm}) {
    this.leftRight = (this.location % _amountOfLocationsPerRow) *
        (_maxLeftRight ~/ _amountOfLocationsPerRow);
    this.upDown = (_amountOfLocationsPerColumn -
            this.location ~/ _amountOfLocationsPerColumn) *
        (_maxUpDown ~/ _amountOfLocationsPerColumn);
    this.motorSpeed = ((this.upDown / _maxUpDown) * _maxMotorSpeed).toInt();

    const ONE_MINUTE = 60000; //In milliseconds
    this.delay = ONE_MINUTE ~/ this.bpm;
    //Todo: Change configurations depending on type of shot.
    switch (this.type) {
      case ShotType.serve:
        break;
      case ShotType.clear:
        break;
      case ShotType.smash:
        break;
      case ShotType.drive:
        break;
      case ShotType.drop:
        break;
      default:
    }
  }

  String toString() {
    return '{${this.delay}, ${this.leftRight}, ${this.upDown}, ${this.motorSpeed}}';
  }
}

class DeviceModel extends Model {
  BluetoothDevice _elon;
  List<BluetoothService> _elonServices = [];
  //Balls per minute
  int _bpm = 0;
  int get bpm => _bpm;
  bool start = false;

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

  Future<bool> readyForSending() async {
    if (_elon == null) return false;
    if (_elonServices.length == 0)
      _elonServices = await _elon.discoverServices();
    return true;
  }

  void sendShot(int bpm, ShotType shotType, int location) async {
    Shot theShot = Shot(bpm: bpm, location: location, type: shotType);
    _sendCommand(theShot.toString());
  }

  void sendStartStop() {
    start = !start;
    String command = "!";
    _sendCommand(command);
  }

//Todo: Now the command writes to ALL characteristics of the connected device. Only send to the one with the correct id?
  void _sendCommand(String command) async {
    if (!(await readyForSending())) return;
    print("Sending command: $command");

    int maxMessageLength = 70; //75 brings OK+Lost.
    for (var i = 0; i < command.length; i += maxMessageLength) {
      String message = command.substring(
          i,
          i + maxMessageLength > command.length
              ? command.length
              : i + maxMessageLength);
      _elonServices[0]
          .characteristics[0]
          .write(utf8.encode(message), withoutResponse: true);
    }
  }

  static DeviceModel of(BuildContext context) =>
      ScopedModel.of<DeviceModel>(context);
}
