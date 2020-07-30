import 'dart:async';
import 'dart:ffi';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:myapp/services/models/Program.dart';
import 'package:myapp/services/models/Routine.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:collection/collection.dart';
import "package:bezier/bezier.dart";
import "package:vector_math/vector_math.dart" hide Colors;
import 'dart:convert';
import 'package:myapp/services/models/Enums.dart';

import 'dart:math' as math;

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

  //TODO: find a way so that _connectedDevicesStream does not have to be periodic (Now it is called every .5 sec)
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
        //Todo: find a way to know if one of the connectedDevices is elon!
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

  //Shooter motors on/off
  bool _start = false;
  bool get start => _start;

  void flipStart() {
    if (!_start) {
      _setupLoading = true;
      notifyListeners();

      new Timer(Duration(seconds: 5), () {
        _start = true;
        _setupLoading = false;
        String command = "!";
        _sendCommand(command);
        notifyListeners();
        print("Timer!");
      });
    } else {
      _start = false;
      _setupLoading = false;
      notifyListeners();
    }
  }

  bool _setupLoading = false;
  bool get setupLoading => _setupLoading;

  void toggleSetupLoading() {
    _setupLoading = !_setupLoading;
    notifyListeners();
  }

  ShotType _shotType = ShotType.serve;
  ShotType get shotType => _shotType;

  void changeShotType(ShotType newType) {
    _shotType = newType;
    notifyListeners();
  }

  //Location of next shot relative to the screen
  Offset _globalShotLocation;
  Offset get globalShotLocation => _globalShotLocation;

  //Location of next shot relative to the court
  Offset _localShotLocation;
  Offset get localShotLocation => _localShotLocation;

  //Position of Elon, center, on Screen
  Offset _offsetDevice;
  Offset get offsetDevice => _offsetDevice;

  void setOffsetDevice(Offset offset) {
    var appBarHeight = AppBar().preferredSize.height;
    _offsetDevice = Offset(offset.dx, offset.dy - appBarHeight - 9);
  }

  void changeShotLocation(
      Offset newGlobalLocation, Offset newLocalLocation, Size courtSize) {
    var appBarHeight = AppBar().preferredSize.height;

    _globalShotLocation =
        Offset(newGlobalLocation.dx, newGlobalLocation.dy - appBarHeight);
    _localShotLocation = newLocalLocation;
    notifyListeners();
  }

  /// delay: the time to wait before shooting next shot in milliseconds.
  /// upDownProportion: value between 0.0 and 1.0, with 0.0 meaning the top of the court and 1.0 the bottom.
  /// leftRightProportion: value between 0.0 and 1.0 with 0.0 meaning the leftmost part of the court and 1.0 the rightmost.
  /// shotType: the type of shot to shoot.
  void sendShot(
      {int delay = 0,
      double upDownProportion = 0,
      double leftRightProportion = 0,
      ShotType shotType = ShotType.serve,
      Offset globalShotPosition}) async {
    if (!start) return;

    if (globalShotPosition != null) {
      var appBarHeight = AppBar().preferredSize.height;
      _globalShotLocation =
          Offset(globalShotPosition.dx, globalShotPosition.dy - appBarHeight);
    }

    delay = delay < 0 ? 0 : delay;
    upDownProportion = upDownProportion > 1.0
        ? 1.0
        : (upDownProportion < 0.0 ? 0.0 : upDownProportion);
    leftRightProportion = leftRightProportion > 1.0
        ? 1.0
        : (leftRightProportion < 0.0 ? 0.0 : leftRightProportion);

    Shot theShot = Shot(
        type: shotType,
        leftRightProportion: leftRightProportion,
        upDownProportion: upDownProportion,
        delay: delay,
        globalPosition: _globalShotLocation);
    print("THeShot: $theShot");
    _sendCommand(theShot.toString());

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

  //PROGRAMS
  List<Program> _programs;
  List<Program> get programs => _programs;

  Future fetchPrograms() async {
    try {
      var response =
          await http.get('https://elon-server.herokuapp.com/programs');
      if (response.statusCode == 200) {
        var jsonPrograms = jsonDecode(response.body)['programs'] as List;
        _programs =
            jsonPrograms.map((program) => Program.fromJson(program)).toList();
        notifyListeners();
      }
    } catch (e) {
      print('error fetching programs');
      print(e);
    }
  }

  Program _currentProgram;
  Program get currentProgram => _currentProgram;



  Future fetchProgram(id) async {
    try {
      print(id);
      var response =
          await http.get('https://elon-server.herokuapp.com/programs/$id');
      if (response.statusCode == 200) {
        var jsonProgram = jsonDecode(response.body)['result'];
        _currentProgram = Program.fromJson(jsonProgram);
        notifyListeners();
      }
    } catch (e) {
      print('error fetching program');
      print(e);
    }
  }

  Program _createProgram = new Program(sets: 3, timeout: 59, routines: List<Routine>());
  Program get createProgram => _createProgram;

  void setSets(int sets){
    _createProgram.sets = sets;
    notifyListeners();
  }  

  void setSetsTimeout(int timeout){
    _createProgram.timeout = timeout;
    notifyListeners();
  }

  void addCreateRoutine(){
    
  }

  

  static DeviceModel of(BuildContext context, {bool rebuildOnChange = false}) =>
      ScopedModel.of<DeviceModel>(context,
          rebuildOnChange: rebuildOnChange == null ? false : rebuildOnChange);
}

class Shot {
  int _maxLeftRight = 100;
  int _maxUpDown = 100;
  int _maxMotorSpeed = 100;

  int leftRight = 0;
  int upDown = 0;

  Offset globalPosition;

  double leftRightProportion = 0.5; //0-100
  double upDownProportion = 0.5; //0-100
  int motorSpeed; //0-100
  int delay; //in milliseconds

  ShotType type;

  String _shotId;
  String get id => _shotId;

  /// location: 0 - (_amountOfColumns*_amountOfRows - 1)
  Shot(
      {@required this.type,
      @required this.leftRightProportion,
      @required this.upDownProportion,
      @required this.delay,
      this.globalPosition}) {
    this.leftRight = (_maxLeftRight * this.leftRightProportion).toInt();
    this.upDown = (_maxUpDown * this.upDownProportion).toInt();
    this.motorSpeed = ((this.upDown / _maxUpDown) * _maxMotorSpeed).toInt();

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

    _shotId = getRandomString(10);
  }

  String toString() {
    return '{${this.delay},${this.leftRight},${this.upDown},${this.motorSpeed}}';
  }
}

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
math.Random _rnd = math.Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
