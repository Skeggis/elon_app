import 'package:flutter/material.dart';
import 'package:myapp/components/screens/CreateOrganizationScreen/components/body.dart';
import 'package:myapp/services/models/Organization.dart';

class CreateOrganizationScreen extends StatelessWidget {
  static const String routeName = '/createOrganization';
  Organization organization; //Is null if is Creating

  CreateOrganizationScreen({this.organization});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
            appBar: AppBar(
              title: Text(this.organization == null
                  ? "Create Organization"
                  : "Edit Organization"),
              backgroundColor: Theme.of(context).backgroundColor,
              elevation: 0.0,
            ),
            resizeToAvoidBottomInset: true,
            backgroundColor: Theme.of(context).backgroundColor,
            body: CreateOrganizationBody(
              organization: organization,
            )),
      ],
    );
  }
}
