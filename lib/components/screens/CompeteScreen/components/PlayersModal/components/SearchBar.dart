import 'package:flutter/material.dart';
import 'package:myapp/styles/theme.dart';
import 'package:myapp/services/helpers.dart';

import 'package:myapp/components/screens/CompeteScreen/components/PlayersModal/components/AddPlayerModal.dart';
import 'package:myapp/routes/router.dart' as router;

class SearchBar extends StatelessWidget {
  TextEditingController controller;
  double height = 50;
  SearchBar({this.height, this.controller});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth(context) * 0.8,
      height: this.height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(blurRadius: 50, color: Colors.black.withOpacity(0.25))
          ],
          color: MyTheme.searchBarColor),
      child: Container(
        child: Center(
            child: Row(children: [
          SizedBox(width: 5),
          Expanded(
            flex: 1,
            child: Icon(
              Icons.search,
              size: 25,
              color: MyTheme.onPrimaryColor.withOpacity(0.65),
            ),
          ),
          SizedBox(width: 5),
          Expanded(
              flex: 8,
              child: TextField(
                controller: controller,
                style: TextStyle(color: MyTheme.onPrimaryColor, fontSize: 17),
                cursorColor: MyTheme.onPrimaryColor.withOpacity(0.5),
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: "Search for player",
                    hintStyle: TextStyle(
                        fontSize: 17,
                        color: MyTheme.onPrimaryColor.withOpacity(0.5))),
              )),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                router.addPlayerModal(context);
              },
              child:
                  Icon(Icons.add_circle, size: 35, color: MyTheme.primaryColor),
            ),
          ),
          SizedBox(width: 15),
        ])),
      ),
    );
  }
}
