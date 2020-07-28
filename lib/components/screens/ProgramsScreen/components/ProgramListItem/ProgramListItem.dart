import 'package:flutter/material.dart';
import 'package:myapp/components/screens/ProgramScreen/ProgramScreen.dart';
import 'package:myapp/components/screens/ProgramScreen/arguments/ProgramScreenArguments.dart';
import 'package:myapp/components/screens/ProgramsScreen/components/ProgramListItem/DescriptionText.dart';
import 'package:myapp/services/helper.dart';
import 'package:myapp/services/models/Program.dart';
import 'package:myapp/styles/theme.dart';
import '../../../../../icons/CustomIcons.dart';

class ProgramListItem extends StatelessWidget {
  final int index;
  final Program program;

  ProgramListItem({this.index, this.program});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 15,
        left: 10,
        right: 10,
        top: index == 0 ? 20 : 0,
      ),
      child: Material(
        elevation: 12,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Theme.of(context).cardColor,
        child: InkWell(
          borderRadius: BorderRadius.circular(5),
          onTap: () => Navigator.pushNamed(
            context,
            ProgramScreen.routeName,
            arguments: ProgramScreenArguments(
              id: program.id,
              name: program.name,
            ),
          ),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(
                    program.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 40),
                  child: DescriptionText(
                    text: program.description,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 20),
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 2),
                            child: Icon(
                              Icons.timer,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                          Text(
                            secondsToMinutes(program.totalTime).toString(),
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 4),
                            child: Icon(
                              MyCustomIcons.badminton,
                              color: Colors.white,
                              size: 19,
                            ),
                          ),
                          Text(
                            program.numShots.toString(),
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Text(
                          '- ${program.author}',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
