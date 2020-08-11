import 'package:myapp/services/models/Routine.dart';

class Program {
  int id;
  String name;
  String description;
  String author;
  int sets;
  int timeout;
  int totalTime;
  int numShots;
  List<Routine> routines = new List<Routine>();

  int displayTimeout;

  Program({
    this.id,
    this.name,
    this.description,
    this.author,
    this.sets,
    this.numShots,
    this.totalTime,
    this.timeout,
    this.routines,
  }){
    displayTimeout = timeout;
  }

  void resetDisplay(){
    displayTimeout = timeout;
  }

  factory Program.fromJson(dynamic json) {
    if (json['routines'] == null) {
      return Program(
        id: json['id'] as int,
        name: json['name'] as String,
        author: json['author'] as String,
        description: json['description'] as String,
        totalTime: json['totalTime'] as int,
        numShots: json['numShots'] as int,
        sets: json['sets'] as int,
        timeout: json['timeout'] as int,
      );
    } else {
      print('her');
      print(json['name']);print(json['routines']);
      var jsonRoutines = json['routines'] as List;
      List<Routine> _routines =
          jsonRoutines.map((routine) => Routine.fromJson(routine)).toList();
      return Program(
          id: json['id'] as int,
          name: json['name'] as String,
          author: json['author'] as String,
          description: json['description'] as String,
          totalTime: json['totalTime'] as int,
          numShots: json['numShots'] as int,
          sets: json['sets'] as int,
          timeout: json['timeout'] as int,
          routines: _routines);
    }
  }



  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> _routines = routines.map((e) => e.toJson()).toList();
    return {
      'id': id,
      'name': name,
      'description': description,
      'author': 'Temp author',
      'sets': sets,
      'timeout': timeout,
      'routines': _routines
    };
  }
}
