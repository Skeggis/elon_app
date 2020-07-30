import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/components/screens/ProgramScreen/arguments/ProgramScreenArguments.dart';
import 'package:myapp/components/screens/ProgramScreen/components/body.dart';
import 'package:myapp/services/helper.dart';

class ProgramScreen extends StatelessWidget {
  static const String routeName = '/program';

  @override
  Widget build(BuildContext context) {

    final ProgramScreenArguments args =
        ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).appBarTheme.color,
        title: Text(args.name),
      ),
      body: ProgramScreenBody(args),
    );
  }
}
