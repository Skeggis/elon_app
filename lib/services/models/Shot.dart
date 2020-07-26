class Shot {
  String name;
  int horizontal;
  int vertical;
  int power;
  String imageUrl;

  Shot({this.name, this.horizontal, this.vertical, this.power, this.imageUrl});

  factory Shot.fromJson(dynamic json){
    return Shot(
      name: json['name'] as String,
      horizontal: json['horizontal'] as int, 
      vertical: json['vertical'] as int,
      power: json['power'] as int,
      imageUrl: json['imageUrl'] as String
    );
  }
}