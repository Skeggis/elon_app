import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/components/screens/ProgramScreen/components/ShotDescription.dart';
import 'package:myapp/services/models/Shot.dart';
import 'package:myapp/services/models/scopedModels/CreateRoutineModel.dart';

class RoutineDescription extends StatelessWidget {
  final List<Shot> routineDesc;
  final bool create;

  RoutineDescription({this.routineDesc, this.create = false});

  @override
  Widget build(BuildContext context) {
    ScrollController controller = create
        ? CreateRoutineModel.of(context).scrollController
        : new ScrollController();

    return Container(
      child: Material(
        elevation: 12,
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(4),
        child: routineDesc.length == 0
            ? Center(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Text('Create a shot...', style: TextStyle(fontSize: 18),),
                ),
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    controller: controller,
                    child: Container(
                      padding: EdgeInsets.only(right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: routineDesc
                            .map((shot) => ShotDescription(shot: shot))
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
