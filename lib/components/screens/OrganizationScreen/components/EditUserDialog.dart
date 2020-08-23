import 'package:flutter/material.dart';

import 'package:myapp/services/models/User.dart';
import 'package:myapp/styles/theme.dart';

typedef void OnDeleteUser(User user);

class EditUserDialog extends StatelessWidget {
  final User user;
  final OnDeleteUser onDeleteUser;
  EditUserDialog({@required this.user, @required this.onDeleteUser});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
            this.user.name ?? 'No Name',
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
                child: Text('Remove User'),
                color: Colors.red[400],
                onPressed: () {
                  this.onDeleteUser(user);
                  Navigator.pop(context);
                },
              ),
              SizedBox(width: 20),
              FlatButton(
                // padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
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
