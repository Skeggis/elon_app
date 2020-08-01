import 'package:flutter/material.dart';
import 'package:myapp/components/screens/ProgramsScreen/components/body.dart';
import 'package:myapp/services/models/ProgramsModel.dart';
import 'package:scoped_model/scoped_model.dart';

class ProgramsScreen extends StatelessWidget {
  static const String routeName = '/programs';

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ProgramsModel>(
      child: ProgramsScreenBody(),
      model: ProgramsModel(),
    );
  }
}
