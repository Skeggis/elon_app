import 'package:myapp/services/models/Routine.dart';

class Program {
  String name;
  String description;
  String author;
  int sets;
  int timeout;
  List<Routine> routines = new List<Routine>();

  Program({
    this.name,
    this.description,
    this.author,
    this.sets,
    this.timeout,
    this.routines,
  });

  factory Program.fromJson(dynamic json) {
    if (json['routines'] == null) {
      return Program(
        name: json['name'] as String,
        author: json['author'] as String,
        description: json['description'] as String,
        sets: json['sets'] as int,
        timeout: json['timeout'] as int,
      );
    } else {
      var jsonRoutines = json['routines'] as List;
      List<Routine> _routines = jsonRoutines.map((routine) => Routine.fromJson(routine)).toList();
      return Program(
        name: json['name'] as String,
        author: json['author'] as String,
        description: json['description'] as String,
        sets: json['sets'] as int,
        timeout: json['timeout'] as int,
        routines: _routines
      );
    }
  }
}
