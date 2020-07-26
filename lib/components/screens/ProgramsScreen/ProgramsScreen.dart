import 'package:flutter/material.dart';
import 'package:myapp/components/screens/ProgramsScreen/components/body.dart';
import 'package:myapp/styles/theme.dart';

class ProgramsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MyTheme theme = MyTheme(context: context);
    return Scaffold(
      appBar: AppBar(),
      body: ProgramsScreenBody(),
    );
  }
}
