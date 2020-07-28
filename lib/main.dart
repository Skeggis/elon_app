import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/routes.dart';
import 'package:myapp/styles/theme.dart';

import 'package:myapp/services/models/DeviceModel.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    MyTheme the = MyTheme(isDark: true, context: context);

    return ScopedModel<DeviceModel>(
      model: DeviceModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // showSemanticsDebugger: true,
        theme: the.themeData,
        initialRoute: "/",
        routes: routes,
      ),
    );
  }
}
