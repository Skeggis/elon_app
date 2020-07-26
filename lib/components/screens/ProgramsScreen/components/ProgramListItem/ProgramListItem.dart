import 'package:flutter/material.dart';
import 'package:myapp/services/helper.dart';

class ProgramListItem extends StatelessWidget {
  final String name;
  final String description;
  final String author;
  final int numShots;
  final int totalTime;

  ProgramListItem({
    this.name,
    this.description,
    this.author,
    this.numShots,
    this.totalTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(4),
          ),
          // boxShadow: [
          //   BoxShadow(blurRadius: 10, color: Colors.grey, spreadRadius: 5),
          // ],

          border: Border.all(color: Colors.grey[200])),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            name,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Text(
              description,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 10),
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 2),
                      child: Icon(
                        Icons.timer,
                        color: Colors.black,
                        size: 22,
                      ),
                    ),
                    Text(
                      secondsToMinutes(totalTime).toString(),
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 2),
                      child: Icon(
                        Icons.arrow_upward,
                        color: Colors.black,
                        size: 22,
                      ),
                    ),
                    Text(numShots.toString(), style: TextStyle(fontSize: 18),)
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: 10),
                  child: Text(
                    '- $author',
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
