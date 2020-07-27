import 'package:flutter/material.dart';
import 'package:myapp/styles/theme.dart';
import 'package:myapp/components/screens/HomeScreen/components/body.dart';
import 'package:myapp/services/models/UIModel.dart';

import 'package:myapp/components/AppDrawer/AppDrawer.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/';
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: MyTheme.backgroundColor),
      child: HomeScreenBody(),
    );
  }
}
