import 'package:flutter/material.dart';
import 'package:myapp/styles/theme.dart';
import 'package:myapp/services/helpers.dart';
import 'package:myapp/components/Logo/Logo.dart';

import 'package:myapp/routes/router.dart' as router;

import 'package:myapp/components/NormalButton/NormalButton.dart';

import 'package:myapp/components/screens/OrganizationScreen/components/SearchBar.dart';

import 'package:myapp/services/models/Organization.dart';
import 'package:myapp/services/models/User.dart';

import 'package:myapp/components/screens/OrganizationScreen/components/AcceptRequestDialog.dart';
import 'package:myapp/components/screens/OrganizationScreen/components/EditUserDialog.dart';

import 'package:myapp/services/ApiRequests.dart';
import 'package:myapp/services/models/Response.dart';
import 'package:myapp/services/models/JoinRequest.dart';

import 'package:myapp/services/helpers.dart' as helpers;

class OrganizationBody extends StatefulWidget {
  Organization organization;
  User joinRequest;

  OrganizationBody({@required this.organization, joinRequest});
  @override
  State<StatefulWidget> createState() => _OrganizationBody();
}

class _OrganizationBody extends State<OrganizationBody> {
  @override
  void initState() {
    super.initState();
  }

  void _onAcceptRequest(User user) {}
  Future<void> _acceptRequestDialog(BuildContext context, User user) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AcceptRequestDialog(
              user: user,
              onAcceptRequest: _onAcceptRequest,
            ));
  }

  void _onDeleteUser(User user) {}
  Future<void> _editUserDialog(BuildContext context, User user) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => EditUserDialog(
              user: user,
              onDeleteUser: _onDeleteUser,
            ));
  }

  Widget _joinRequestItem(BuildContext context, User user) {
    double borderRadius = 10;
    return Container(
      margin: EdgeInsets.only(top: 7.5, bottom: 7.5, left: 15, right: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.fromBorderSide(BorderSide(color: Colors.grey, width: 1)),
        // boxShadow: [BoxShadow(blurRadius: 50, color: Colors.black)]
      ),
      child: Container(
        width: 300,
        height: 70,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.25),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Container(
          child: Material(
            borderRadius: BorderRadius.circular(borderRadius),
            color: Colors.transparent,
            child: InkWell(
              highlightColor: Colors.transparent,
              onTap: () => _acceptRequestDialog(context, user),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 15),
                  Icon(
                    Icons.account_circle,
                    size: 30,
                    color: MyTheme.onPrimaryColor,
                  ),
                  SizedBox(width: 10),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // SizedBox(height: 10),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(user.name ?? 'No Name',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 17)),
                        ),
                        // SizedBox(height: 5),
                        // Text('Wants to join',
                        //     style: TextStyle(
                        //         fontSize: 15,
                        //         color: Theme.of(context)
                        //             .primaryTextTheme
                        //             .bodyText1
                        //             .color
                        //             .withOpacity(0.5)))
                      ],
                    ),
                  ),
                  SizedBox(width: 15),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _userItem(BuildContext context, User user) {
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
              onTap: () => {},
              child: Padding(
                padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                child: Stack(
                  // mainAxisSize: MainAxisSize.max,
                  // mainAxisAlignment: MainAxisAlignment.,
                  children: [
                    Align(
                      alignment: Alignment(-0.95, 0.0),
                      child: Icon(
                        Icons.account_circle,
                        size: 30,
                        color: MyTheme.onPrimaryColor,
                      ),
                    ),
                    SizedBox(width: 10),
                    Align(
                      alignment: Alignment(-0.65, 0.0),
                      child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(user.name ?? 'No Name',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 17))),
                    ),
                    Align(
                      alignment: Alignment(0.95, 0.0),
                      child: IconButton(
                          icon: Icon(
                            Icons.more_vert,
                            size: 30,
                            color: MyTheme.onPrimaryColor,
                          ),
                          onPressed: () => _editUserDialog(context, user)),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Column(children: [
      Icon(
        Icons.account_circle,
        size: 75,
        color: MyTheme.onPrimaryColor,
      ),
      SizedBox(height: 10),
      Text(
        widget.organization.name ?? 'No Name',
        style: TextStyle(
            color: Theme.of(context)
                .primaryTextTheme
                .bodyText1
                .color
                .withOpacity(0.75)),
        textAlign: TextAlign.center,
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: Column(
          children: [
            _header(context),
            widget.joinRequest == null
                ? Expanded(
                    child: Container(
                      // decoration: BoxDecoration(color: Colors.blue),
                      child: RefreshIndicator(
                        color: Theme.of(context).splashColor,
                        onRefresh: () async {
                          Response response =
                              await ApiRequests.refreshOrganization(
                                  widget.organization.id);
                          if (response.success) {
                            return setState(() {
                              widget.organization =
                                  response.organization == null
                                      ? widget.organization
                                      : response.organization;
                            });
                          }
                          return helpers.showSnackBar(
                              context,
                              response.errors == null ||
                                      response.errors.length == 0
                                  ? ["Could not process your request"]
                                  : response.errors);
                        },
                        child: ListView(
                          // mainAxisSize: MainAxisSize.min,
                          // shrinkWrap: true,
                          children: [
                            SizedBox(height: 25),
                            Center(child: Text("Join Requests: ")),
                            SizedBox(height: 5),
                            ...[
                              for (User user
                                  in widget.organization.joinRequests ?? [])
                                _joinRequestItem(context, user)
                            ],
                            SizedBox(height: 25),
                            Center(child: Text("Members: ")),
                            SizedBox(height: 5),
                            for (User user in widget.organization.members ?? [])
                              _userItem(context, user),
                            SizedBox(height: 100),
                          ],
                        ),
                      ),
                    ),
                  )
                : Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [_joinRequestItem(context, widget.joinRequest)],
                    ),
                  ),
            // SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
