import 'dart:developer';

import 'package:myapp/services/models/Organization.dart';

class User {
  String name;
  String uuid;
  String email;
  int organizationId;

  User({
    this.name,
    this.uuid,
    this.email,
    this.organizationId,
  });

  factory User.fromJson(dynamic json) {
    print("USERSTHING");
    return User(
      name: json['name'] as String,
      uuid: json['uuid'] as String,
      email: json['email'] as String,
      organizationId: json['organization_id'] as int,
    );
  }
}
