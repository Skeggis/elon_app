import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/components/screens/ProgramScreen/components/ShotDescription.dart';
import 'package:myapp/services/models/Shot.dart';
import 'package:myapp/services/models/scopedModels/CreateRoutineModel.dart';

class RoutineDescription extends StatelessWidget {
  final List<Shot> routineDesc;
  final ScrollController scrollController;
  final Function handleDelete;

  RoutineDescription({
    this.routineDesc,
    this.scrollController,
    this.handleDelete,
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
            : Stack(
                children: [
                  handleDelete != null
                      ? Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            onPressed: handleDelete,
                            icon: Icon(Icons.close),
                          ),
                        )
                      : Container(),
                  Container(
                    padding:
                        EdgeInsets.only(top: handleDelete != null ? 15 : 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          controller: scrollController,
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
                ],
              ),
      ),
    );
  }
}
