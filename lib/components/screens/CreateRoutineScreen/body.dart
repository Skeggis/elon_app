import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:myapp/components/screens/ControllerScreen/components/body.dart';
import 'package:myapp/services/helpers.dart';

class CreateRoutineBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CreateRoutineBody();
  }
}

class _CreateRoutineBody extends State<CreateRoutineBody> {
  List<Map<String, dynamic>> shotLocations;
  int numShot = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    shotLocations = [
      {'location': 'left', 'shots': []},
      {'location': 'center', 'shots': []},
      {'location': 'right', 'shots': []},
      {'location': 'left', 'shots': []},
      {'location': 'center', 'shots': []},
      {'location': 'right', 'shots': []},
      {'location': 'left', 'shots': []},
      {'location': 'center', 'shots': []},
      {'location': 'right', 'shots': []},
    ];
  }

  void shotAdded(int index) {
    List<dynamic> l = shotLocations[index]['shots'];
    l.add({'numShot': numShot});
    setState(() {
      shotLocations[index]['shots'] = l;
      numShot += 1;
    });

    
  }

   createShotDialog()  {
    // showDialog(
    //   context: context,
    //   builder: (context) => {
    //     return AlertDialog()
    //   }
    // )
  }

  @override
  Widget build(BuildContext context) {
    print((screenWidth(context) - 30) * (6.7 / 6.1));
    Widget court = Container(
      child: RepaintBoundary(
        child: Container(
          height: (screenWidth(context) - 30) * (6.7 / 6.1),
          width: screenWidth(context) - 30,
          child: CustomPaint(
            painter: CourtPainter(),
          ),
        ),
      ),
    );

    return Container(
      height: (screenWidth(context) - 30) * (6.7 / 6.1),
      child: Stack(
        children: <Widget>[
          Align(
            child: court,
            alignment: Alignment(0, -0.95),
          ),
          Align(
            child: Container(
              height: (screenWidth(context) - 30) * (6.7 / 6.1),
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 40),
              child: Stack(
                children: <Widget>[
                  Container(
                    alignment: Alignment.topLeft,
                    child: ShotList(
                        shotLocation: shotLocations[0],
                        handlePress: () => shotAdded(0)),
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    child: ShotList(
                        shotLocation: shotLocations[1],
                        handlePress: () => shotAdded(1)),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    child: ShotList(
                        shotLocation: shotLocations[2],
                        handlePress: () => shotAdded(2)),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: ShotList(
                        shotLocation: shotLocations[3],
                        handlePress: () => shotAdded(3)),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: ShotList(
                        shotLocation: shotLocations[4],
                        handlePress: () => shotAdded(4)),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: ShotList(
                        shotLocation: shotLocations[5],
                        handlePress: () => shotAdded(5)),
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: ShotList(
                        shotLocation: shotLocations[6],
                        handlePress: () => shotAdded(6)),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: ShotList(
                        shotLocation: shotLocations[7],
                        handlePress: () => shotAdded(7)),
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: ShotList(
                        shotLocation: shotLocations[8],
                        handlePress: () => shotAdded(8)),
                  ),
                ],
              ),
              alignment: Alignment(0, 0.95),
            ),
          ),
        ],
      ),
    );
  }
}

class ShotList extends StatelessWidget {
  final dynamic shotLocation;
  final Function handlePress;
  ShotList({this.shotLocation, this.handlePress});

  @override
  Widget build(BuildContext context) {
    String location = shotLocation['location'];
    CrossAxisAlignment crossAlignment;
    MainAxisAlignment mainAxisAlignment;
    if (location == 'left') {
      crossAlignment = CrossAxisAlignment.start;
      mainAxisAlignment = MainAxisAlignment.start;
    } else if (location == 'center') {
      crossAlignment = CrossAxisAlignment.center;
      mainAxisAlignment = MainAxisAlignment.center;
    } else {
      crossAlignment = CrossAxisAlignment.end;
      mainAxisAlignment = MainAxisAlignment.end;
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: crossAlignment,
      children: <Widget>[
        IconButton(
          onPressed: handlePress,
          icon: Icon(Icons.add_circle),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: mainAxisAlignment,
          children: shotLocation['shots']
              .map<Widget>(
                (shot) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 2),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Text(
                    shot['numShot'].toString(),
                  ),
                ),
              )
              .toList(),
        )
      ],
    );
  }
}
