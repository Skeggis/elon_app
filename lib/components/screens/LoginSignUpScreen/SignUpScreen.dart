import 'package:flutter/material.dart';
import 'package:myapp/components/screens/LoginSignUpScreen/components/SignUpBody.dart';
import 'package:myapp/styles/theme.dart';
import 'package:myapp/services/models/UIModel.dart';

class SignUpScreen extends StatelessWidget {
  static const String routeName = '/SignUp';
  @override
  Widget build(BuildContext context) {
    bool loading = UIModel.of(context, rebuildOnChange: true).loading;
    return Stack(
      children: [
        Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              backgroundColor: MyTheme.barBackgroundColor,
              elevation: 0.0,
              title: Text('Sign Up'),
            ),
            backgroundColor: MyTheme.backgroundColor,
            body: SignUpBody()),
        loading ? Center(child: CircularProgressIndicator()) : Container()
      ],
    );
  }
}
