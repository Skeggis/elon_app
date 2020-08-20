import 'package:flutter/material.dart';
import 'package:myapp/components/screens/OrganizationScreen/components/NoOrganizationBody.dart';
import 'package:myapp/components/screens/OrganizationScreen/components/OrganizationBody.dart';
import 'package:myapp/styles/theme.dart';
import 'package:myapp/services/models/UserModel.dart';
import 'package:myapp/services/models/UIModel.dart';
import 'package:myapp/services/models/Response.dart';
import 'package:myapp/routes/Routes.dart';
import 'package:myapp/services/ApiRequests.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:myapp/services/models/scopedModels/OrganizationModel.dart';
import 'package:myapp/services/models/Organization.dart';

import 'package:myapp/routes/router.dart' as router;

class OrganizationScreen extends StatelessWidget {
  static const String routeName = '/organization';

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      Future<Response> myOrganizationResponse =
          OrganizationModel.of(context).getMyOrganization();
      return Stack(
        children: [
          FutureBuilder(
              future: myOrganizationResponse,
              builder: (context, snapshot) {
                bool memberOfOrg =
                    OrganizationModel.of(context, rebuildOnChange: true)
                        .isMemberOfOrganization;
                List<Organization> organizations =
                    OrganizationModel.of(context, rebuildOnChange: true)
                        .organizations;
                Organization organization =
                    OrganizationModel.of(context, rebuildOnChange: true)
                        .organization;
                if (snapshot.connectionState == ConnectionState.done) {
                  return Scaffold(
                      floatingActionButton: memberOfOrg
                          ? FloatingActionButton(
                              onPressed: () {
                                if (organization.isOwner) {
                                  router.editOrganization(context);
                                } else {}
                              },
                              child: Icon(organization.isOwner
                                  ? Icons.settings
                                  : Icons.logout))
                          : FloatingActionButton(
                              onPressed: () =>
                                  router.createOrganization(context),
                              child: Icon(Icons.add),
                            ),
                      resizeToAvoidBottomInset: true,
                      backgroundColor: MyTheme.backgroundColor,
                      body: memberOfOrg
                          ? OrganizationBody(organization: organization)
                          : NoOrganizationBody(
                              organizations: organizations,
                            ));
                }
                // By default, show a loading spinner.
                return Center(child: CircularProgressIndicator());
              })
        ],
      );
    });
  }
}
