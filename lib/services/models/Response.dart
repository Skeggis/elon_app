import 'package:myapp/services/models/Organization.dart';
import 'package:myapp/services/models/JoinRequest.dart';

class Response {
  List<String> errors;
  bool success;
  Organization organization;
  List<Organization> organizations;
  JoinRequest joinRequest;

  Response(
      {this.errors,
      this.success,
      this.organization,
      this.organizations,
      this.joinRequest});

  factory Response.fromJson(Map<String, dynamic> json) {
    print("thing: ${json['organizations']}");
    List<Organization> test = json['organizations'] == null
        ? null
        : (json['organizations'] as List)
            .map((org) => Organization.fromJson(org))
            .toList();
    print("massi");
    return Response(
      errors: json['errors'] == null
          ? null
          : (json['errors'] as List<dynamic>).cast<String>(),
      success: json['success'],
      organization: json['organization'] == null
          ? null
          : Organization.fromJson(json['organization']),
      organizations: json['organizations'] == null
          ? null
          : (json['organizations'] as List)
              .map((org) => Organization.fromJson(org))
              .toList(),
      joinRequest: json['joinRequest'] == null
          ? null
          : JoinRequest.fromJson(json['joinRequest']),
    );
  }
}
