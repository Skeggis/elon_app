import 'package:myapp/services/models/Shot.dart';

class ShotLocation {
  final int id;
  final String name;
  final List<Shot> shots;

  ShotLocation({this.id, this.name, this.shots});

  factory ShotLocation.fromJson(dynamic json) {
    var shotsJson = json['shots'] as List;
    List<Shot> _shots = shotsJson.map((shot) => Shot.fromJson(shot)).toList();
    
    return ShotLocation(
      id: json['id'] as int,
      name: json['name'],
      shots: _shots,
    );
  }
}
