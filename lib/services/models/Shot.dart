class Shot {
  String typeName;
  String locationName;
  int locationId;
  int timeout;
  int horizontal;
  int vertical;
  int power;

  Shot({
    this.typeName,
    this.locationName,
    this.locationId,
    this.timeout,
    this.horizontal,
    this.vertical,
    this.power,
  });

  factory Shot.fromJson(dynamic json) {
    return Shot(
      typeName: json['typeName'] as String,
      locationName: json['locationName'] as String,
      locationId: json['locationId'] as int,
      timeout: json['timeout'] as int,
      horizontal: json['horizontal'] as int,
      vertical: json['vertical'] as int,
      power: json['power'] as int,
    );
  }
}
