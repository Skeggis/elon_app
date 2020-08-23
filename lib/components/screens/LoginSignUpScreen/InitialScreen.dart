import 'package:flutter/material.dart';
import 'package:myapp/components/screens/LoginSignUpScreen/components/InitialBody.dart';
import 'package:myapp/styles/theme.dart';
import 'package:myapp/services/models/UserModel.dart';
import 'package:myapp/services/models/UIModel.dart';

class InitialScreen extends StatelessWidget {
  static const String routeName = '/Initial';

  @override
  Widget build(BuildContext context) {
    bool loading = UIModel.of(context, rebuildOnChange: true).loading;
    UserModel.of(context).checkIfUserIsLoggedIn();
    return Stack(
      children: [
        Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: MyTheme.backgroundColor,
            body: InitialBody()),
        loading ? Center(child: CircularProgressIndicator()) : Container()
      ],
    );
  }
}
