import 'package:flutter/material.dart';
import 'package:myapp/components/screens/ProgramsScreen/components/body.dart';
import 'package:myapp/styles/theme.dart';

class ProgramsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: MyTheme.barBackgroundColor,
        title: Text(
          'Programs',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: ProgramsScreenBody(),
    );
  }
}
