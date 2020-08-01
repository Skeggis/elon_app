import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myapp/services/models/Program.dart';
import 'package:myapp/services/models/Routine.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

class ProgramsModel extends Model{


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
        print(_currentProgram.sets);
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

    static ProgramsModel of(BuildContext context,
          {bool rebuildOnChange = false}) =>
      ScopedModel.of<ProgramsModel>(context,
          rebuildOnChange: rebuildOnChange == null ? false : rebuildOnChange);
}