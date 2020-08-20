import 'package:flutter/material.dart';

import 'package:myapp/services/models/Organization.dart';
import 'package:myapp/styles/theme.dart';

typedef void OnJoinOrganization(Organization organization);

class JoinRequestDialog extends StatelessWidget {
  final Organization organization;
  final OnJoinOrganization onJoinOrganization;
  JoinRequestDialog(
      {@required this.organization, @required this.onJoinOrganization});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // title: Text(this.organization.name),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.account_circle,
            size: 75,
            color: MyTheme.onPrimaryColor,
          ),
          SizedBox(height: 10),
          Text(
            this.organization.name,
            style: TextStyle(
                color: Theme.of(context)
                    .primaryTextTheme
                    .bodyText1
                    .color
                    .withOpacity(0.75)),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                child: Text('Join'),
                onPressed: () {
                  this.onJoinOrganization(organization);
                  Navigator.pop(context);
                },
              ),
              SizedBox(width: 20),
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel', style: TextStyle(color: Colors.white)),
              )
            ],
          ),
        ],
      ),
    );
  }
}
