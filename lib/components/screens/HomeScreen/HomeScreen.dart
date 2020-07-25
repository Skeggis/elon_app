import 'package:flutter/material.dart';
import 'package:myapp/styles/theme.dart';
import 'package:myapp/components/screens/HomeScreen/components/body.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
            padding: EdgeInsets.only(left: 25.0),
            child: Icon(Icons.menu, size: 30.0)),
        backgroundColor: MyTheme.barBackgroundColor,
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
      backgroundColor: MyTheme.backgroundColor,
      body: HomeScreenBody(),
    );
  }
}
