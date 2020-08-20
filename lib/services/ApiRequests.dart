import 'package:http/http.dart' as http;
import 'package:myapp/services/models/Response.dart';
import 'package:myapp/services/UsersPreferences.dart';
import 'dart:convert';

class ApiRequests {
  static final String baseUrl = 'https://elon-server.herokuapp.com';
  static final String organizationUrl =
      'https://elon-server.herokuapp.com/organization';

  static Future<Response> createOrganization(
      String imageUrl, String name) async {
    print("CUD");
    Map data = {
      'imageUrl': imageUrl,
      'name': name,
      'uuid': await UsersPreferences.getUsersUUID()
    };

    print("HERESONESISE");

    Response response = await genericPostApiRequest(
        organizationUrl + '/createOrganization', data);

    return response;
  }

  static Future<Response> getMyOrganization() async {
    Map data = {'uuid': await UsersPreferences.getUsersUUID()};

    Response response = await genericPostApiRequest(
        organizationUrl + '/getMyOrganization', data);

    return response;
  }

  static Future<Response> requestToJoinOrganization(int organizationId) async {
    Map data = {
      'uuid': await UsersPreferences.getUsersUUID(),
      'organization_id': organizationId
    };

    Response response = await genericPostApiRequest(
        organizationUrl + '/requestToJoinOrganization', data);

    return response;
  }

/**
 * userUUID: uuid of joinRequest user
 */
  static Future<Response> answerJoinRequest(int organizationId, String userUUID,
      {bool accept = false}) async {
    Map data = {
      'uuid': await UsersPreferences.getUsersUUID(),
      'organization_id': organizationId,
      'user_uuid': userUUID,
      'accept': accept,
    };

    Response response = await genericPostApiRequest(
        organizationUrl + '/answerJoinRequest', data);

    return response;
  }

/**
 * userUUID: uuid of member to delete
 */
  static Future<Response> deleteMemberFromOrganization(
      int organizationId, String userUUID) async {
    Map data = {
      'uuid': await UsersPreferences.getUsersUUID(),
      'organization_id': organizationId,
      'user_uuid': userUUID,
    };

    Response response = await genericPostApiRequest(
        organizationUrl + '/deleteMemberFromOrganization', data);

    return response;
  }

  static Future<Response> leaveOrganization(int organizationId) async {
    Map data = {
      'uuid': await UsersPreferences.getUsersUUID(),
      'organization_id': organizationId,
    };

    Response response = await genericPostApiRequest(
        organizationUrl + '/leaveOrganization', data);

    return response;
  }

  static Future<Response> refreshOrganization(int organizationId) async {
    Map data = {
      'uuid': await UsersPreferences.getUsersUUID(),
      'organization_id': organizationId,
    };

    Response response = await genericPostApiRequest(
        organizationUrl + '/refreshOrganization', data);

    return response;
  }

  static Future<Response> refreshOrganizations() async {
    Map data = {
      'uuid': await UsersPreferences.getUsersUUID(),
    };

    Response response = await genericPostApiRequest(
        organizationUrl + '/refreshOrganizations', data);

    return response;
  }

  static Future<Response> genericPostApiRequest(String url, Map data) async {
    var body = json.encode(data);

    try {
      var response = await http.post(url,
          headers: {"Content-Type": "application/json"}, body: body);
      print("${response.statusCode}");
      print("${response.body}");

      dynamic bodyDecoded = jsonDecode(response.body);
      Response responseClass = Response.fromJson(bodyDecoded);

      if (response.statusCode == 200) {
      } else {}

      return responseClass;
    } catch (e) {
      print('error posting stuff');
      print(e);
      return Response(success: false, errors: ["Error trying to execute"]);
    }
  }
}
