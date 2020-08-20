import 'package:flutter/material.dart';
import 'package:myapp/components/screens/CreateOrganizationScreen/components/body.dart';

class CreateOrganizationScreen extends StatelessWidget {
  static const String routeName = '/createOrganization';
  bool isCreating;

  CreateOrganizationScreen({this.isCreating = true});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
            appBar: AppBar(
              title: Text("Create Organization"),
              backgroundColor: Theme.of(context).backgroundColor,
              elevation: 0.0,
            ),
            resizeToAvoidBottomInset: true,
            backgroundColor: Theme.of(context).backgroundColor,
            body: CreateOrganizationBody(isCreating: this.isCreating)),
      ],
    );
  }
}
