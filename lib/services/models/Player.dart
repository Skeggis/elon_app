import 'package:myapp/services/models/Organization.dart';

class Player {
  String id;
  String name;
  String imageUrl;
  Organization organization;
  Player({this.name, this.imageUrl, this.organization, this.id});

  factory Player.fromJson(dynamic json) {
    return Player(
      name: json['name'] as String,
      id: json['id'] as String,
      imageUrl: json['image'] as String,
      organization: Organization.fromJson(json['organization']),
    );
  }
}
