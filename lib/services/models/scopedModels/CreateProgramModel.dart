import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myapp/components/CustomSnackBar/CustomSnackBar.dart';
import 'package:myapp/components/Dialogs/MessageDialog.dart';
import 'package:myapp/routes/router.dart';
import 'package:myapp/services/helper.dart';
import 'package:myapp/services/models/Program.dart';
import 'package:myapp/services/models/Routine.dart';
import 'package:myapp/services/models/Shot.dart';
import 'package:myapp/services/models/ShotLocation.dart';
import 'package:myapp/services/models/ShotType.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/routes/router.dart' as router;

class CreateProgramModel extends Model {
  final String url = 'https://elon-server.herokuapp.com/programs';
  final int _initialSets = 3;
  final int _initialSetTimeout = 59;
  final int _initialRounds = 1;
  final int _initialRoundTimeout = 10;

  List<ShotLocation> shotLocations;
  Program program;
  Function onSetsFocusLost;
  Function onRoundsFocusLost;
  Function onRoundTimeoutFocusLost;
  Function onRoundTimeoutFocusGained;

  CreateProgramModel() {
    program = new Program(
        sets: _initialSets,
        timeout: _initialSetTimeout,
        routines: new List<Routine>());

    onSetsFocusLost = (TextEditingController controller) {
      var parse = int.tryParse(controller.text);
      if (parse == null) {
        program.sets = _initialSets;
        controller.text = _initialSets.toString();
      } else {
        program.sets = parse;
      }
    };

    onRoundsFocusLost = (TextEditingController controller, int index) {
      var parse = int.tryParse(controller.text);
      if (parse == null) {
        program.routines[index].rounds = _initialRounds;
        controller.text = _initialRounds.toString();
      } else {
        program.routines[index].rounds = parse;
      }
    };
  }

  Future<void> fetchShots() async {
    try {
      var response = await http.get('$url/shots');
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        print(jsonResponse);
        shotLocations = jsonResponse['result']
            .map<ShotLocation>((location) => ShotLocation.fromJson(location))
            .toList();
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  bool createProgramLoading = false;
  Future<Map<String, dynamic>> createProgram(BuildContext context) async {
    createProgramLoading = true;
    notifyListeners();
    try {
      var response = await http.post('$url',
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(program.toJson()));
      if (response.statusCode == 201) {
        createProgramLoading = false;
        notifyListeners();
        return {'success': true};
      }
    } catch (e) {
      createProgramLoading = false;
      notifyListeners();
      print(e);
      return {'success': false, 'message': 'Error creating'};
    }
    return {'success': false, 'message': 'Error creating'};
  }

  Future<bool> validate(BuildContext context) async {
    if (program.name == null || program.name == '') {
      await showDialog(
        context: context,
        builder: (context) => MessageDialog(
            title: 'Alert',
            message: 'Insert a valid name',
            handleClose: () => Navigator.pop(context)),
      );
      return false;
    } else if (program.description == null || program.description == '') {
      await showDialog(
        context: context,
        builder: (context) => MessageDialog(
            title: 'Alert',
            message: 'Insert a valid description',
            handleClose: () => Navigator.pop(context)),
      );
      return false;
    }
    return true;
  }

  String name = '';
  String description = '';

  void setName(value) {
    program.name = value;
    notifyListeners();
  }

  void setDescription(value) {
    program.description = value;
    notifyListeners();
  }

  void setRoutineTimeout(Duration duration, int index) {
    program.routines[index].timeout = duration.inSeconds;
    notifyListeners();
  }

  void setSets(int sets) {
    program.sets = sets;
    notifyListeners();
  }

  void setSetsTimeout(int timeout) {
    program.timeout = timeout;
    notifyListeners();
  }

  void addRoutine(Routine routine) {
    routine.rounds = _initialRounds;
    routine.timeout = _initialRoundTimeout;
    program.routines.add(routine);
    notifyListeners();
  }

  void removeRoutine(int index) {
    program.routines.removeAt(index);
    print(index);
    notifyListeners();
  }

  void updateRoutineDesc(int index, List<Shot> routineDesc) {
    program.routines[index].routineDesc = routineDesc;
    notifyListeners();
  }

  static CreateProgramModel of(BuildContext context,
          {bool rebuildOnChange = false}) =>
      ScopedModel.of<CreateProgramModel>(context,
          rebuildOnChange: rebuildOnChange == null ? false : rebuildOnChange);
}
