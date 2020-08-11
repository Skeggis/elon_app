import 'package:myapp/services/models/ShotType.dart';

class Shot {
  int id;
  ShotType shotType;
  String locationName;
  int locationId;
  int timeout;
  int horizontal;
  int vertical;
  int power;

  int displayTimeout;

  Shot({
    this.id,
    this.shotType,
    this.locationName,
    this.locationId,
    this.timeout,
    this.horizontal,
    this.vertical,
    this.power,
  }) {
    displayTimeout = timeout;
  }

  void resetDisplay() {
    displayTimeout = timeout;
  }



  factory Shot.fromJson(dynamic json) {
    var shotType = ShotType.fromJson(json['shotType']);
    return Shot(
      id: json['id'] as int,
      shotType: shotType,
      locationName: json['locationName'] as String,
      locationId: json['locationId'] as int,
      timeout: json['timeout'] as int,
      horizontal: json['horizontal'] as int,
      vertical: json['vertical'] as int,
      power: json['power'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'shotType': shotType.toJson(),
        'locationName': locationName,
        'locationId': locationId,
        'timeout': timeout,
        'horizontal': horizontal,
        'vertical': vertical,
        'power': power,
      };

      String toString(){
        return '{${this.timeout},${this.horizontal},${this.vertical},${this.power}}';
      }
}
