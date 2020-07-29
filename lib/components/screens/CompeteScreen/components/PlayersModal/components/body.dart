import 'package:flutter/material.dart';
import 'package:myapp/components/screens/CompeteScreen/components/PlayersModal/components/SearchBar.dart';
import 'package:myapp/styles/theme.dart';

class PlayersModalBody extends StatelessWidget {
  Organization tbr = new Organization(
    name: 'Tennis og Badmintonfélag Reykjavíkur',
  );
  List<Player> players = [
    new Player(
      name: 'Þórður Ágústsson',
      organization: new Organization(
        name: 'Badmintonfélag Hafnarfjarðar',
      ),
    ),
    new Player(
      name: 'Róbert Ingi Huldarsson',
      organization: new Organization(
        name: 'Badmintonfélag Hafnarfjarðar',
      ),
    ),
    new Player(
      name: 'Þórður Ágústsson',
      organization: new Organization(
        name: 'Badmintonfélag Hafnarfjarðar',
      ),
    ),
    new Player(
      name: 'Róbert Ingi Huldarsson',
      organization: new Organization(
        name: 'Badmintonfélag Hafnarfjarðar',
      ),
    ),
    new Player(
      name: 'Þórður Ágústsson',
      organization: new Organization(
        name: 'Badmintonfélag Hafnarfjarðar',
      ),
    ),
    new Player(
      name: 'Róbert Ingi Huldarsson',
      organization: new Organization(
        name: 'Badmintonfélag Hafnarfjarðar',
      ),
    )
  ];

  Widget playerItem(BuildContext context, Player player) {
    double borderRadius = 10;
    return Container(
      margin: EdgeInsets.only(bottom: 7.5, left: 15, right: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [BoxShadow(blurRadius: 50, color: Colors.black)]),
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        width: 300,
        // height: 120,
        decoration: BoxDecoration(
          color: MyTheme.backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Material(
          borderRadius: BorderRadius.circular(borderRadius),
          color: Colors.transparent,
          child: InkWell(
            highlightColor: Colors.transparent,
            onTap: () {},
            child: Column(
              children: [
                SizedBox(height: 15),
                Row(
                  children: [
                    SizedBox(width: 10),
                    Icon(
                      Icons.account_circle,
                      size: 30,
                      color: MyTheme.onPrimaryColor,
                    ),
                    SizedBox(width: 10),
                    Text(player.name,
                        style: TextStyle(
                            fontSize: 20, color: MyTheme.onPrimaryColor))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(player.organization.name,
                        style: TextStyle(
                            fontSize: 15,
                            color: MyTheme.onPrimaryColor.withOpacity(0.5))),
                    SizedBox(width: 10),
                    Icon(
                      Icons.help,
                      size: 25,
                      color: MyTheme.onPrimaryColor.withOpacity(0.95),
                    ),
                    SizedBox(width: 25),
                  ],
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget cancelButton(BuildContext context) {
    return MaterialButton(
        padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
        onPressed: () => Navigator.pop(context),
        child: Text('Cancel',
            style: TextStyle(fontSize: 20, color: MyTheme.onPrimaryColor)),
        shape: OutlineInputBorder(
          borderSide: BorderSide(color: MyTheme.onPrimaryColor, width: 2),
          borderRadius: BorderRadius.circular(5),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(height: 20),
        SearchBar(),
        SizedBox(height: 20),
        Expanded(
          flex: 1,
          child: ListView(
            children: [
              for (Player player in players) playerItem(context, player),
            ],
          ),
        ),
        cancelButton(context),
        SizedBox(height: 20),
      ],
    );
  }
}

class Player {
  String id;
  String name;
  String imageUrl;
  Organization organization;
  Player({this.name, this.imageUrl, this.organization, this.id});
}

class Organization {
  String id;
  String name;
  String imageUrl;
  Organization({this.name, this.imageUrl, this.id});
}
