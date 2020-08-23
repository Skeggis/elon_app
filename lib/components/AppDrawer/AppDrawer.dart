import 'package:flutter/material.dart';
import 'package:myapp/routes/Routes.dart';

import 'package:myapp/services/models/UIModel.dart';

import 'package:myapp/styles/theme.dart';
import 'package:myapp/services/models/UserModel.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget _createHeader() {
      return Container(
        height: 100,
        child: DrawerHeader(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            // decoration: BoxDecoration(color: MyTheme.barBackgroundColor),
            child: Stack(children: <Widget>[
              Positioned(
                  bottom: 12.0,
                  left: 16.0,
                  child: Text("Elon maskínan",
                      style: TextStyle(
                          // color: MyTheme.onPrimaryColor,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500))),
            ])),
      );
    }

    Widget _createDrawerItem(
        {IconData icon, String text, GestureTapCallback onTap}) {
      return ListTile(
        //tileColor: MyTheme.backgroundColor,
        title: Row(
          children: <Widget>[
            Icon(icon, size: 25),
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                text,
                style: TextStyle(
                    // color: MyTheme.onPrimaryColor,
                    ),
              ),
            )
          ],
        ),
        onTap: onTap,
      );
    }

    Widget _divider() {
      return Divider(
          indent: 40,
          // color: MyTheme.barBackgroundColor,
          thickness: 1,
          height: 1);
    }

    return Drawer(
      child: Container(
        constraints: BoxConstraints.expand(),
        // decoration: BoxDecoration(color: MyTheme.backgroundColor),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            _createHeader(),
            _createDrawerItem(
              icon: Icons.home,
              text: 'Home',
              onTap: () {
                Navigator.pop(context);
                UIModel.of(context).changeRoute(Routes.home);
              },
            ),
            _divider(),
            _createDrawerItem(
              icon: Icons.list,
              text: 'Programs',
              onTap: () {
                Navigator.pop(context);
                UIModel.of(context).changeRoute(Routes.programs);
              },
            ),
            _divider(),
            _createDrawerItem(
              icon: Icons.location_city,
              text: 'Organization',
              onTap: () {
                Navigator.pop(context);
                UIModel.of(context).changeRoute(Routes.organization);
              },
            ),
            // _divider(),
            // _createDrawerItem(
            //   // icon: Icons.sports, hmm virkar ekki hjá mér
            //   icon: Icons.ac_unit,
            //   text: 'Compete',
            //   onTap: () {
            //     Navigator.pop(context);
            //     UIModel.of(context).changeRoute(Routes.compete);
            //   },
            // ),
            _divider(),
            _createDrawerItem(
              icon: Icons.bluetooth,
              text: 'Connect to Elon',
              onTap: () {
                Navigator.pop(context);
                UIModel.of(context).changeRoute(Routes.bluetoothConnect);
              },
            ),
            _divider(),
            _createDrawerItem(
              icon: Icons.settings,
              text: 'Settings',
            ),

            // _divider(),
            // _createDrawerItem(
            //   icon: Icons.leaderboard,
            //   text: 'Stats',
            // ),
            _divider(),
            _createDrawerItem(
                icon: Icons.exit_to_app,
                text: 'Logout',
                onTap: () {
                  Navigator.pop(context);

                  UserModel.of(context).logout();
                  UIModel.of(context).changeRoute(Routes.login);
                }),
            _divider(),
            ListTile(
              title: Text(
                'v. 1.0.1',
                // style: TextStyle(color: MyTheme.onPrimaryColor),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
