import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:collection/collection.dart';
import "package:bezier/bezier.dart";
import 'dart:convert';

class DeviceModel extends Model {
  //Connection things
  BluetoothDevice _elon;
  BluetoothDevice get elon => _elon;
  List<BluetoothService> _elonServices = [];

  StreamSubscription<List<BluetoothDevice>> _connectedDevicesStream;
  List<BluetoothDevice> _connectedDevices;
  List<BluetoothDevice> get connectedDevices => _connectedDevices;
  StreamSubscription<List<ScanResult>> _scanResultStream;
  List<BluetoothDevice> _foundDevices = [];
  List<BluetoothDevice> get foundDevices => _foundDevices;
  DeviceModel() {
    Function eq = const ListEquality().equals;
    // Function deepEq = const DeepCollectionEquality().equals;
    _connectedDevicesStream = Stream.periodic(Duration(milliseconds: 500))
        .asyncMap((_) => FlutterBlue.instance.connectedDevices)
        .listen((newConnectedDevices) async {
      if (!eq(_connectedDevices, newConnectedDevices)) {
        _connectedDevices = newConnectedDevices;
        if (!_connectedDevices.contains(_elon)) {
          if (_elon != null) {
            if (_foundDevices == null) {
              _foundDevices = [];
            }
            _foundDevices.insert(0, _elon);
          }
          _elon = null;
          _elonServices = [];
        }
        //Todo: find a way to know if one the connectedDevices is elon!
        if (_elon == null && _connectedDevices.length > 0) {
          _elon = _connectedDevices[0];
          _elonServices = await _elon.discoverServices();
          _foundDevices.remove(_elon);
        }
        notifyListeners();
      }
    });
    _scanResultStream = FlutterBlue.instance.scanResults.listen((result) {
      var filtered =
          result.where((r) => r.device.name != '' && r.device != _elon);
      _foundDevices = [...filtered.map((r) => r.device).toList()];
      notifyListeners();
    });
    scanForDevices();
  }

  void scanForDevices() {
    FlutterBlue.instance.startScan(timeout: Duration(seconds: 4));
  }

  void connect(BluetoothDevice device) {
    device.connect();
  }

  void disconnect(BluetoothDevice device) {
    device.disconnect();
  }

/* --------------------------------------------------------- */

  //GAME PLAY

  //Balls per minute
  int _bpm = 60;
  int get bpm => _bpm;
  int _shotLocation = -1;
  int get shotLocation => _shotLocation;
  bool _start = false;
  bool get start => _start;

  double _xShotLocation = 0;
  double _yShotLocation = 0;
  Offset get offsetLocation => Offset(_xShotLocation, _yShotLocation);
  Offset _offsetDevice;
  Offset get offsetDevice => _offsetDevice;
  void setOffsetDevice(Offset offset) {
    var appBarHeight = AppBar().preferredSize.height;
    _offsetDevice = Offset(offset.dx, offset.dy - appBarHeight - 5);
  }

  void changeShotLocation(double x, double y) {
    var appBarHeight = AppBar().preferredSize.height;
    _xShotLocation = x;
    _yShotLocation = y - appBarHeight - 35;
    notifyListeners();
  }

  void changeLocation(int loc) {
    _shotLocation = loc;
    notifyListeners();
  }

  void changeBPM(int add) {
    _bpm += add;
    if (_bpm < 1) _bpm = 1;
    if (_bpm > 60) _bpm = 60;
    notifyListeners();
  }

  void sendShot(ShotType shotType, int shotLocation) async {
    print("StartSendShot");
    Shot theShot = Shot(bpm: _bpm, shotLocation: shotLocation, type: shotType);
    print("THeShot: $theShot");
    _sendCommand(theShot.toString());
  }

  void flipStart() {
    _start = !_start;
    String command = "!";
    _sendCommand(command);
    notifyListeners();
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
    print("Command Sent!");
  }

  Future<bool> readyForSending() async {
    if (_elon == null) return false;
    if (_elonServices.length == 0)
      _elonServices = await _elon.discoverServices();
    return true;
  }

  static DeviceModel of(BuildContext context, {bool rebuildOnChange = false}) =>
      ScopedModel.of<DeviceModel>(context,
          rebuildOnChange: rebuildOnChange == null ? false : rebuildOnChange);
}

enum ShotType { serve, clear, smash, drive, drop }

class CourtConfiguration {
  static const int amountOfColumns = 3;
  static const int amountOfRows = 3;
}

class Shot {
  int _maxLeftRight = 100;
  int _maxUpDown = 100;
  int _maxMotorSpeed = 100;

  int leftRight; //0-100
  int upDown; //0-100
  int motorSpeed; //0-100
  int delay; //in milliseconds

  int bpm; //Balls per minute
  int shotLocation;
  ShotType type;

  /// location: 0 - (_amountOfColumns*_amountOfRows - 1)
  Shot({@required this.type, @required this.shotLocation, @required this.bpm}) {
    // this.leftRight = (this.shotLocation % CourtConfiguration.amountOfColumns) *
    //     (_maxLeftRight ~/ CourtConfiguration.amountOfColumns);
    this.leftRight = this.shotLocation % 3 == 0 ? 0 : 100;
    this.upDown = this.shotLocation ~/ 3 == 0 ? 100 : 0;
    this.upDown = (CourtConfiguration.amountOfRows -
            this.shotLocation ~/ CourtConfiguration.amountOfRows) *
        (_maxUpDown ~/ CourtConfiguration.amountOfRows);
    this.motorSpeed = ((this.upDown / _maxUpDown) * _maxMotorSpeed).toInt();

    const ONE_MINUTE = 60000; //In milliseconds
    print("Here $bpm");
    this.delay = ONE_MINUTE ~/ this.bpm;
    print("HEer");
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
    return '{${this.delay},${this.leftRight},${this.upDown},${this.motorSpeed}}';
  }
}
