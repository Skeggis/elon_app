import 'package:flutter/material.dart';
import 'package:myapp/styles/theme.dart';
import 'package:myapp/services/helpers.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth(context) * 0.8,
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(blurRadius: 50, color: Colors.black.withOpacity(0.25))
          ],
          color: MyTheme.searchBarColor),
      child: Center(
          child: Row(children: [
        SizedBox(width: 10),
        Expanded(
          flex: 1,
          child: Icon(
            Icons.search,
            size: 30,
            color: MyTheme.onPrimaryColor.withOpacity(0.65),
          ),
        ),
        Expanded(
          flex: 8,
          child: Padding(
            padding: const EdgeInsets.only(top: 2.0, left: 8),
            child: Text("Search for player",
                style: TextStyle(
                    fontSize: 17,
                    color: MyTheme.onPrimaryColor.withOpacity(0.50))),
          ),
        ),
        Expanded(
          flex: 1,
          child: InkWell(
            onTap: () {},
            child:
                Icon(Icons.add_circle, size: 35, color: MyTheme.primaryColor),
          ),
        ),
        SizedBox(width: 15),
      ])),
    );
  }
}
