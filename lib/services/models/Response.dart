import 'package:myapp/services/models/Organization.dart';
import 'package:myapp/services/models/User.dart';

class Response {
  List<String> errors;
  bool success;
  Organization organization;
  List<Organization> organizations;
  User joinRequest;
  Organization requestingOrganization;

  Response({
    this.errors,
    this.success,
    this.organization,
    this.organizations,
    this.joinRequest,
    this.requestingOrganization,
  });

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
      requestingOrganization:
          Organization.fromJson(json['requestingOrganization']),
      joinRequest: json['joinRequest'] == null
          ? null
          : User.fromJson(json['joinRequest']),
    );
  }
}
