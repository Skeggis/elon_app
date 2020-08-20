import 'package:scoped_model/scoped_model.dart';
import 'package:myapp/services/ApiRequests.dart';
import 'package:myapp/services/models/Organization.dart';
import 'package:myapp/services/models/Response.dart';
import 'package:flutter/material.dart';

class OrganizationModel extends Model {
  Future<Response> getMyOrganization() async {
    Response response = await ApiRequests.getMyOrganization();

    _isMemberOfOrganization =
        response.organizations == null || response.organizations.length == 0;
    _organizations = response.organizations;
    _organization = response.organization;
    notifyListeners();
    return response;
  }

  Future<Response> createOrganization(String imageUrl, String name) async {
    print("FUN");
    Response response = await ApiRequests.createOrganization(imageUrl, name);
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

  static OrganizationModel of(BuildContext context,
          {bool rebuildOnChange = false}) =>
      ScopedModel.of<OrganizationModel>(context,
          rebuildOnChange: rebuildOnChange == null ? false : rebuildOnChange);
}
