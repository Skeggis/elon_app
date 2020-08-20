import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myapp/services/models/Program.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

class ProgramsModel extends Model {
  final String url = 'https://elon-server.herokuapp.com/programs';

  List<Program> _programs;
  List<Program> get programs => _programs;

  Future<void> fetchPrograms() async {
    try {
      var response = await http.get(url);
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
    return null;
  }

 





  static ProgramsModel of(BuildContext context,
          {bool rebuildOnChange = false}) =>
      ScopedModel.of<ProgramsModel>(context,
          rebuildOnChange: rebuildOnChange == null ? false : rebuildOnChange);
}
