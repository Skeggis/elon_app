import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:myapp/components/screens/ControllerScreen/components/body.dart';
import 'package:myapp/components/screens/CreateRoutineScreen/CreateShotDialog.dart';
import 'package:myapp/components/screens/ProgramScreen/components/RoutineDescription.dart';
import 'package:myapp/services/helper.dart';
import 'package:myapp/services/helpers.dart';
import 'package:myapp/services/models/Routine.dart';
import 'package:myapp/services/models/Shot.dart';
import 'package:myapp/services/models/scopedModels/CreateRoutineModel.dart';
import 'package:myapp/styles/theme.dart';

class CreateRoutineBody extends StatelessWidget {
  Future<void> createShotDialog(
    int index,
    List<Shot> shots,
    BuildContext myContext,
  ) async {
    CreateRoutineModel.of(myContext).initializeShotDialog();
    return showDialog(
        barrierDismissible: false,
        context: myContext,
        builder: (context) => CreateShotDialog(myContext, index));
  }

  createAlertDialog(BuildContext context, title, message) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('OK',
                style: TextStyle(color: MyTheme.secondaryColor, fontSize: 18)),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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

    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: (screenWidth(context) - 30) * (6.7 / 6.1),
                child: Stack(
                  children: <Widget>[
                    Align(
                      child: court,
                      alignment: Alignment(0, -0.95),
                    ),
                    Align(
                      alignment: Alignment(0, -1.2),
                      child: Container(
                        height: (screenWidth(context) - 30) * (6.7 / 6.1),
                        padding:
                            EdgeInsets.symmetric(vertical: 30, horizontal: 40),
                        child: Stack(
                          children: CreateRoutineModel.of(context)
                              .shotLocations
                              .asMap()
                              .entries
                              .map<Widget>(
                                (entry) => Container(
                                  alignment:
                                      mapLocationIdToAlignment(entry.value.id),
                                  child: IconButton(
                                    icon: mapLocationIdToIcon(entry.value.id),
                                    onPressed: () async =>
                                        await createShotDialog(entry.value.id,
                                            entry.value.shots, context),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                        alignment: Alignment(0, 0.95),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 30),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child:
                          CreateRoutineModel.of(context, rebuildOnChange: true)
                                      .shots
                                      .length ==
                                  0
                              ? Container()
                              : Container(
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                  child: RoutineDescription(
                                    routineDesc: CreateRoutineModel.of(context,
                                            rebuildOnChange: true)
                                        .shots,
                                    create: true,
                                  ),
                                ),
                    ),
                    Container(
                      child: FloatingActionButton(
                          child: Icon(Icons.save),
                          onPressed: () {
                            CreateRoutineModel model =
                                CreateRoutineModel.of(context);
                            if (model.shots.length == 0) {
                              createAlertDialog(context, 'Routine empty',
                                  'You can not create a empty routine. Try adding a shot');
                            } else {
                              Routine routine = model.createRoutine();
                              Navigator.of(context).pop(routine);
                            }
                          }),
                      margin: EdgeInsets.only(right: 20),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

AlignmentGeometry mapLocationIdToAlignment(int id) {
  switch (id) {
    case 1:
      return Alignment.topLeft;
      break;
    case 2:
      return Alignment.topCenter;
      break;
    case 3:
      return Alignment.topRight;
      break;
    case 4:
      return Alignment.centerLeft;
      break;
    case 5:
      return Alignment.center;
      break;
    case 6:
      return Alignment.centerRight;
      break;
    case 7:
      return Alignment.bottomLeft;
      break;
    case 8:
      return Alignment.bottomCenter;
      break;
    case 9:
      return Alignment.bottomRight;
      break;
    default:
      return Alignment.center;
  }
}

Widget mapLocationIdToIcon(int id) {
  switch (id) {
    case 1:
      return Transform.rotate(
        angle: degToRad(-45),
        child: Icon(Icons.arrow_upward),
      );
      break;
    case 2:
      return Transform.rotate(
        angle: degToRad(0),
        child: Icon(Icons.arrow_upward),
      );
      break;
    case 3:
      return Transform.rotate(
        angle: degToRad(45),
        child: Icon(Icons.arrow_upward),
      );
      break;
    case 4:
      return Transform.rotate(
        angle: degToRad(-90),
        child: Icon(Icons.arrow_upward),
      );
      break;
    case 5:
      return Icon(Icons.radio_button_unchecked);
      break;
    case 6:
      return Transform.rotate(
        angle: degToRad(90),
        child: Icon(Icons.arrow_upward),
      );
      break;
    case 7:
      return Transform.rotate(
        angle: degToRad(-135),
        child: Icon(Icons.arrow_upward),
      );
      break;
    case 8:
      return Transform.rotate(
        angle: degToRad(180),
        child: Icon(Icons.arrow_upward),
      );
      break;
    case 9:
      return Transform.rotate(
        angle: degToRad(135),
        child: Icon(Icons.arrow_upward),
      );
      break;
    default:
      return Icon(Icons.error_outline);
  }
}
