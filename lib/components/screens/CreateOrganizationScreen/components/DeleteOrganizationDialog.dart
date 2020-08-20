import 'package:flutter/material.dart';

import 'package:myapp/services/models/Organization.dart';
import 'package:myapp/styles/theme.dart';

class DeleteOrganizationDialog extends StatelessWidget {
  final Organization organization;
  Function onDeleteOrganization;
  DeleteOrganizationDialog(
      {@required this.organization, this.onDeleteOrganization});
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
            (this.organization.name ?? 'No Name') +
                " wants to join your organization",
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
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                color: Colors.red[400],
                child: Text('Delete organization'),
                onPressed: () {
                  this.onDeleteOrganization();
                  Navigator.pop(context);
                },
              ),
              SizedBox(width: 20),
              OutlineButton(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                onPressed: () => Navigator.pop(context),
                // borderSide: BorderSide(color: Colors.red[400], width: 1),
                child: Text('Cancel', style: TextStyle(color: Colors.white)),
              )
            ],
          ),
        ],
      ),
    );
  }
}
