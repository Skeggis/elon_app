import 'package:flutter/material.dart';
import 'package:myapp/styles/theme.dart';
import 'package:myapp/components/screens/CompeteScreen/components/body.dart';
import 'package:myapp/services/models/scopedModels/CompeteModel.dart';

import 'package:scoped_model/scoped_model.dart';

class CompeteScreen extends StatelessWidget {
  static const String routeName = '/CompeteScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.backgroundColor,
      body: ScopedModel<CompeteModel>(
          model: CompeteModel(), child: CompeteScreenBody()),
    );
  }
}
