import 'package:flutter/material.dart';
import 'package:myapp/components/screens/CompeteScreen/components/PlayersModal/components/SearchBar.dart';
import 'package:myapp/styles/theme.dart';
import 'package:myapp/services/models/Player.dart';
import 'package:myapp/services/models/PlayersModel.dart';

class PlayersModalBody extends StatelessWidget {
  // double searchBarHeight = 50;

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

  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    controller.addListener(() {
      PlayersModel.of(context).newSearch(controller.text);
    });
    // return Container(
    //   height: 200,
    //   decoration: BoxDecoration(color: Colors.blue),
    // );
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onPanDown: (_) {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: playersList(context),
        ),
        // cancelButton(context),
        // SizedBox(height: 20),
      ],
    );
  }

  Widget playersList(BuildContext context) {
    return FutureBuilder(
      future: PlayersModel.of(context).fetchAllPlayers(),
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          List<Player> players =
              PlayersModel.of(context, rebuildOnChange: true).playersInSearch;
          if (players == null || players.length == 0) {
            return Center(
              child: Text(
                'No players found',
              ),
            );
          } else {
            return RefreshIndicator(
              color: Theme.of(context).splashColor,
              onRefresh: PlayersModel.of(context).fetchAllPlayers,
              child: ListView(
                shrinkWrap: true,
                children: [
                  // SizedBox(height: 20),
                  // for (Player player in players) playerItem(context, player),
                  // SizedBox(height: 35),
                ],
              ),
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
