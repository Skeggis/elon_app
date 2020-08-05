class ShotType {
  int id;
  String name;

  ShotType({this.id, this.name});

  factory ShotType.fromJson(dynamic json) {
    return ShotType(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
  };
}
