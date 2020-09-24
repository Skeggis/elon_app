import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/components/screens/ProgramScreen/components/ShotDescription.dart';
import 'package:myapp/services/models/Shot.dart';
import 'package:myapp/services/models/scopedModels/CreateRoutineModel.dart';
import 'package:myapp/services/models/scopedModels/ProgramModel.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class RoutineDescription extends StatelessWidget {
  final List<Shot> routineDesc;
  final ItemScrollController scrollController;
  final int index;
  final bool editable;

  RoutineDescription({
    this.routineDesc,
    this.scrollController,
    this.index,
    this.editable = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        elevation: 12,
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(4),
        child: routineDesc.length == 0
            ? Center(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'Create a shot...',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              )
            : Container(
                height: 80,
                // child: Column(
                //   mainAxisSize: MainAxisSize.min,
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   controller: scrollController,
                //   child: Container(
                //     padding: EdgeInsets.only(right: 20),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.start,
                //       children: routineDesc.asMap().
                //           entries.map((entry) => ShotDescription(shot: entry.value, creating: creating, routineIndex: index, shotIndex: entry.key,))
                //           .toList(),
                //     ),
                //   ),
                // ),

                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ScrollablePositionedList.builder(
                          itemCount: routineDesc.length,
                          scrollDirection: Axis.horizontal,
                          itemScrollController: scrollController,
                          itemBuilder: (context, i) => Container(
                                margin: EdgeInsets.only(
                                    right:
                                        i == routineDesc.length - 1 ? 20 : 0),
                                child: ShotDescription(
                                    shot: routineDesc[i],
                                    routineIndex: index,
                                    shotIndex: i,
                                    editable: editable),
                              )),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
