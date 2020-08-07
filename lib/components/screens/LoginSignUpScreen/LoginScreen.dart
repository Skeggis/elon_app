import 'package:flutter/material.dart';
import 'package:myapp/components/screens/LoginSignUpScreen/components/LoginBody.dart';
import 'package:myapp/styles/theme.dart';
import 'package:myapp/services/models/UserModel.dart';
import 'package:myapp/services/models/UIModel.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/Login';

  @override
  Widget build(BuildContext context) {
    bool loading = UIModel.of(context, rebuildOnChange: true).loading;
    UserModel.of(context).checkIfUserIsLoggedIn();
    return Stack(
      children: [
        Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Theme.of(context).backgroundColor,
            body: LoginBody()),
        loading ? Center(child: CircularProgressIndicator()) : Container()
      ],
    );
  }
}
