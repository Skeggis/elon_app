import 'package:flutter/material.dart';
import 'package:myapp/services/models/User.dart';
import 'package:myapp/styles/theme.dart';
import 'package:myapp/services/helpers.dart' as helpers;
import 'package:myapp/components/Logo/Logo.dart';

import 'package:myapp/routes/router.dart' as router;

import 'package:myapp/components/NormalButton/NormalButton.dart';

import 'package:myapp/components/screens/OrganizationScreen/components/SearchBar.dart';

import 'package:myapp/services/models/Organization.dart';

import 'package:myapp/components/screens/OrganizationScreen/components/JoinRequestDialog.dart';
import 'package:myapp/services/ApiRequests.dart';
import 'package:myapp/services/models/Response.dart';

class NoOrganizationBody extends StatefulWidget {
  List<Organization> organizations;

  NoOrganizationBody({@required this.organizations});
  @override
  State<StatefulWidget> createState() => _NoOrganizationBody();
}

class _NoOrganizationBody extends State<NoOrganizationBody> {
  List<Organization> organizations = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      organizations = widget.organizations;
    });
  }

  void _onJoinOrganization(Organization org) {}

  Future<void> _joinRequestDialog(
      BuildContext context, Organization org) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => JoinRequestDialog(
              organization: org,
              onJoinOrganization: _onJoinOrganization,
            ));
  }

  Widget _members(BuildContext context, int amount) {
    return Container(
      clipBehavior: Clip.none,
      constraints: BoxConstraints.expand(),
      child: Stack(
        children: [
          Positioned(
            right: 25,
            bottom: 5,
            child: Text(amount.toString(),
                style: TextStyle(
                    fontSize: 14,
                    color: MyTheme.onPrimaryColor.withOpacity(0.5))),
          ),
          Positioned(
            right: 5,
            bottom: 5,
            child: Icon(
              Icons.people,
              size: 18,
              color: MyTheme.onPrimaryColor.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _organizationItem(BuildContext context, Organization organization) {
    double borderRadius = 10;
    return Container(
      margin: EdgeInsets.only(top: 7.5, bottom: 7.5, left: 15, right: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [BoxShadow(blurRadius: 50, color: Colors.black)]),
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        width: 300,
        height: 70,
        decoration: BoxDecoration(
          color: MyTheme.backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Material(
          borderRadius: BorderRadius.circular(borderRadius),
          color: Colors.transparent,
          child: InkWell(
              highlightColor: Colors.transparent,
              onTap: () => _joinRequestDialog(context, organization),
              child: Padding(
                padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Icon(
                        Icons.account_circle,
                        size: 30,
                        color: MyTheme.onPrimaryColor,
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(organization.name,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 17))),
                    ),
                    Expanded(
                        flex: 1,
                        child: _members(context, organization.members?.length)),
                  ],
                ),
              )),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: Column(
          children: [
            SearchBar(
              height: 50,
              searchHint: "Search for organization to join",
            ),
            Expanded(
              child: RefreshIndicator(
                color: Theme.of(context).splashColor,
                onRefresh: () async {
                  Response response = await ApiRequests.refreshOrganizations();
                  if (response.success) {
                    return setState(() {
                      organizations = response.organizations == null
                          ? []
                          : response.organizations;
                    });
                  }
                  return helpers.showSnackBar(
                      context,
                      response.errors == null || response.errors.length == 0
                          ? ["Could not process your request"]
                          : response.errors);
                },
                child: Container(
                  // decoration: BoxDecoration(color: Colors.blue),
                  child: Expanded(
                    child: ListView(
                      // mainAxisSize: MainAxisSize.min,
                      // shrinkWrap: true,
                      children: [
                        SizedBox(height: 25),
                        for (Organization org in organizations)
                          _organizationItem(context, org),
                        SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
