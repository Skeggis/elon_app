import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:myapp/components/screens/ControllerScreen/components/body.dart';
import 'package:myapp/services/helper.dart';
import 'package:myapp/services/helpers.dart';
import 'package:myapp/styles/theme.dart';

class CreateRoutineBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CreateRoutineBody();
  }
}

class _CreateRoutineBody extends State<CreateRoutineBody> {
  TextEditingController _controller;
  FocusNode _focusNode;

  List<Map<String, dynamic>> shotLocations;
  int numShot = 1;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
    shotLocations = [
      {
        'location': 'left',
        'shots': [],
        'icon': Transform.rotate(
          angle: degToRad(-45),
          child: Icon(Icons.arrow_upward),
        ),
        'alignment': Alignment.topLeft
      },
      {
        'location': 'center',
        'shots': [],
        'icon': Transform.rotate(
          angle: degToRad(0),
          child: Icon(Icons.arrow_upward),
        ),
        'alignment': Alignment.topCenter
      },
      {
        'location': 'right',
        'shots': [],
        'icon': Transform.rotate(
          angle: degToRad(45),
          child: Icon(Icons.arrow_upward),
        ),
        'alignment': Alignment.topRight
      },
      {
        'location': 'left',
        'shots': [],
        'icon': Transform.rotate(
          angle: degToRad(-90),
          child: Icon(Icons.arrow_upward),
        ),
        'alignment': Alignment.centerLeft
      },
      {
        'location': 'center',
        'shots': [],
        'icon': Icon(Icons.radio_button_unchecked),
        'alignment': Alignment.center
      },
      {
        'location': 'right',
        'shots': [],
        'icon': Transform.rotate(
          angle: degToRad(90),
          child: Icon(Icons.arrow_upward),
        ),
        'alignment': Alignment.centerRight
      },
      {
        'location': 'left',
        'shots': [],
        'icon': Transform.rotate(
          angle: degToRad(-135),
          child: Icon(Icons.arrow_upward),
        ),
        'alignment': Alignment.bottomLeft
      },
      {
        'location': 'center',
        'shots': [],
        'icon': Transform.rotate(
          angle: degToRad(180),
          child: Icon(Icons.arrow_upward),
        ),
        'alignment': Alignment.bottomCenter
      },
      {
        'location': 'right',
        'shots': [],
        'icon': Transform.rotate(
          angle: degToRad(135),
          child: Icon(Icons.arrow_upward),
        ),
        'alignment': Alignment.bottomRight
      },
    ];

    _controller.text = '1';
    _focusNode.addListener(() {
      // if(!_focusNode.hasFocus){
      //   if()
      // }
    });
  }

  void shotAdded(int index) async {
    await createShotDialog();

    List<dynamic> l = shotLocations[index]['shots'];
    l.add({'numShot': numShot});
    setState(() {
      shotLocations[index]['shots'] = l;
      numShot += 1;
    });
  }

  Future<void> createShotDialog() async {
    Widget inputShotTimeout = Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(
          width: 30,
          height: 32,
          child: TextField(
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(bottom: 10),
            ),
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
            controller: _controller,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text('s'),
      ],
    );

    Widget chooseShotType = DropdownButton(
      onChanged: (value) {},
      items: [
        DropdownMenuItem(
          child: Text('Smash'),
        ),
        DropdownMenuItem(
          child: Text('Drop'),
        )
      ],
    );

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Create shot'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [chooseShotType, inputShotTimeout],
            )
          ],
        ),
      ),
    );
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
            painter: CourtPainter(testColor: Colors.grey[700]),
          ),
        ),
      ),
    );

    return Center(
      child: SingleChildScrollView(
        child: Container(
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
                    children: shotLocations
                        .asMap()
                        .entries
                        .map((entry) => Container(
                              alignment: entry.value['alignment'],
                              child: ShotList(
                                  shotLocation: entry.value,
                                  handlePress: () => shotAdded(entry.key)),
                            ))
                        .toList(),
                  ),
                  alignment: Alignment(0, 0.95),
                ),
              ),
            ],
          ),
        ),
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
          iconSize: 30,
          onPressed: handlePress,
          icon: shotLocation['icon'],
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
