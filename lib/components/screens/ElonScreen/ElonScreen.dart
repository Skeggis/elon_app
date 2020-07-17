import 'package:flutter/material.dart';
import 'package:myapp/styles/theme.dart';
import 'package:myapp/components/screens/ElonScreen/components/body.dart';

class ElonScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MyTheme theme = MyTheme(context: context);
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
            padding: EdgeInsets.only(left: 25.0),
            child: Icon(Icons.settings, size: 30.0)),
        backgroundColor: theme.darkBackgroundColor,
        elevation: 0.0,
        title: Text('Elon'),
        actions: [
          Padding(
              child: IconButton(
                icon: Icon(Icons.bluetooth, size: 30.0),
                onPressed: () => Navigator.pushReplacementNamed(context, '/'),
              ),
              padding: EdgeInsets.only(right: 25.0))
        ],
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: ElonScreenBody(),
      // child: ,
    );
  }
}
