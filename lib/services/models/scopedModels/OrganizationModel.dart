import 'package:scoped_model/scoped_model.dart';
import 'package:myapp/services/ApiRequests.dart';
import 'package:myapp/services/models/Organization.dart';
import 'package:myapp/services/models/Response.dart';
import 'package:flutter/material.dart';
import 'package:myapp/services/helpers.dart' as helpers;
import 'package:myapp/services/models/User.dart';

class OrganizationModel extends Model {
  Future<Response> getMyOrganization({BuildContext context}) async {
    Response response = await ApiRequests.getMyOrganization();

    _isMemberOfOrganization =
        response.organizations == null || response.organizations.length == 0;
    _organizations = response.organizations;
    _organization = response.organization;

    if (context != null &&
        !response.success &&
        (response.errors != null && response.errors.length > 0)) {
      helpers.showSnackBar(context, response.errors);
    }
    notifyListeners();
    return response;
  }

  Future<Response> createOrganization(String imageUrl, String name) async {
    print("FUN");
    Response response = await ApiRequests.createOrganization(imageUrl, name);
    if (response.success) {
      _organization = response.organization;
      _organizations = [];
      _isMemberOfOrganization = true;
      notifyListeners();
    }
    return response;
  }

  Future<Response> deleteOrganization(int organizationId) async {
    print("FUN");
    Response response = await ApiRequests.deleteOrganization(organizationId);
    if (response.success) {
      _organization = response.organization;
      _organizations = response.organizations;
      _isMemberOfOrganization = false;
      notifyListeners();
    }
    return response;
  }

  Future<Response> joinOrganization(int organizationId) async {
    print("FUN");
    Response response = await ApiRequests.joinOrganization(organizationId);
    if (response.success) {
      _organization = response.organization;
      _organizations = response.organizations;
      _joinRequest = response.joinRequest;
      _isMemberOfOrganization = true;
      // _isMemberOfOrganization = false;
      notifyListeners();
    }
    return response;
  }

  Future<Response> editOrganization(
      String imageUrl, String name, int organizationId) async {
    print("FUN");
    Response response =
        await ApiRequests.editOrganization(imageUrl, name, organizationId);
    if (response.success) {
      _organization = response.organization;
      _organizations = [];
      notifyListeners();
    }
    return response;
  }

  bool _isMemberOfOrganization = false;
  bool get isMemberOfOrganization => _isMemberOfOrganization;

  List<Organization> _organizations;
  List<Organization> get organizations => _organizations;

  Organization _organization;
  Organization get organization => _organization;

  User _joinRequest;
  User get joinRequest => _joinRequest;

  static OrganizationModel of(BuildContext context,
          {bool rebuildOnChange = false}) =>
      ScopedModel.of<OrganizationModel>(context,
          rebuildOnChange: rebuildOnChange == null ? false : rebuildOnChange);
}
