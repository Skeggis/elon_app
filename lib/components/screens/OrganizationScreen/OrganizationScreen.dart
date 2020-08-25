import 'package:flutter/material.dart';
import 'package:myapp/components/screens/OrganizationScreen/components/NoOrganizationBody.dart';
import 'package:myapp/components/screens/OrganizationScreen/components/OrganizationBody.dart';
import 'package:myapp/styles/theme.dart';
import 'package:myapp/services/models/scopedModels/UserModel.dart';
import 'package:myapp/services/models/UIModel.dart';
import 'package:myapp/services/models/Response.dart';
import 'package:myapp/routes/Routes.dart';
import 'package:myapp/services/ApiRequests.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:myapp/services/models/scopedModels/OrganizationModel.dart';
import 'package:myapp/services/models/Organization.dart';
import 'package:myapp/services/models/User.dart';

import 'package:myapp/routes/router.dart' as router;
import 'package:myapp/services/helpers.dart' as helpers;

class OrganizationScreen extends StatefulWidget {
  static const String routeName = '/organization';

  @override
  _OrganizationScreenState createState() => _OrganizationScreenState();
}

class _OrganizationScreenState extends State<OrganizationScreen> {
  Future<Response> myOrganizationResponse;

  @override
  void initState() {
    super.initState();
    setState(() {
      myOrganizationResponse =
          OrganizationModel.of(context).getMyOrganization(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    bool memberOfOrg = OrganizationModel.of(context, rebuildOnChange: true)
        .isMemberOfOrganization;
    List<Organization> organizations =
        OrganizationModel.of(context, rebuildOnChange: true).organizations;
    Organization organization =
        OrganizationModel.of(context, rebuildOnChange: true).organization;
    User joinRequest =
        OrganizationModel.of(context, rebuildOnChange: true).joinRequest;

    print(organizations);
    print("Organization");
    print(organization == null ? "noOrg" : organization.name);
    return Builder(builder: (BuildContext context) {
      return Stack(
        children: [
          FutureBuilder(
              future: myOrganizationResponse,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    Response res = snapshot.data;
                    if (!res.success) {
                      return Center(
                          child: Text("Error!",
                              style: TextStyle(color: Colors.white)));
                    }
                  }
                  return Scaffold(
                      floatingActionButton: memberOfOrg
                          ? (organization.isOwner
                              ? FloatingActionButton(
                                  onPressed: () {
                                    router.editOrganization(
                                        context, organization);
                                  },
                                  child: Icon(organization.isOwner
                                      ? Icons.settings
                                      : Icons.exit_to_app),
                                )
                              : null)
                          : FloatingActionButton(
                              onPressed: () =>
                                  router.createOrganization(context),
                              child: Icon(Icons.add),
                            ),
                      resizeToAvoidBottomInset: true,
                      backgroundColor: MyTheme.backgroundColor,
                      body: memberOfOrg
                          ? OrganizationBody(
                              organization: organization,
                              joinRequest: joinRequest)
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
