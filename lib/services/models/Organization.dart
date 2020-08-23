import 'package:myapp/services/models/User.dart';
import 'package:myapp/services/models/JoinRequest.dart';

class Organization {
  int id;
  String name;
  String imageUrl;
  List<User> members;
  List<User> joinRequests;
  bool isOwner;

  Organization(
      {this.name,
      this.imageUrl,
      this.id,
      this.members,
      this.joinRequests,
      this.isOwner});

  factory Organization.fromJson(dynamic json) {
    print("ORGANZIATSJSON");

    return Organization(
      name: json['name'] as String,
      id: json['id'] as int,
      imageUrl: json['image'] as String,
      isOwner: json['isOwner'] as bool,
      members: json['members'] == null
          ? null
          : (json['members'] as List)
              .map((user) => User.fromJson(user))
              .toList(),
      joinRequests: json['joinRequests'] == null
          ? null
          : (json['joinRequests'] as List)
              .map((user) => User.fromJson(user))
              .toList(),
    );
  }
}
