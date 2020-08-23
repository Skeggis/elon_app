import 'package:flutter/material.dart';

import 'package:myapp/services/models/User.dart';
import 'package:myapp/styles/theme.dart';

typedef void OnAcceptRequest(User user);

class AcceptRequestDialog extends StatelessWidget {
  final User user;
  final OnAcceptRequest onAcceptRequest;
  AcceptRequestDialog({@required this.user, @required this.onAcceptRequest});
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
            (this.user.name ?? 'No Name') + " wants to join your organization",
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
                child: Text('Accept'),
                onPressed: () {
                  this.onAcceptRequest(user);
                  Navigator.pop(context);
                },
              ),
              SizedBox(width: 20),
              OutlineButton(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                onPressed: () => Navigator.pop(context),
                borderSide: BorderSide(color: Colors.red[400], width: 1),
                child: Text('Decline', style: TextStyle(color: Colors.white)),
              )
            ],
          ),
        ],
      ),
    );
  }
}
