import 'package:flutter/material.dart';
import 'package:myapp/services/models/UserModel.dart';
import 'package:myapp/components/Logo/Logo.dart';
import 'package:myapp/styles/theme.dart';
import 'package:myapp/services/helpers.dart';
import 'package:myapp/routes/router.dart' as router;

import 'package:myapp/components/screens/LoginSignUpScreen/components/TheForm.dart';
import 'package:myapp/components/screens/LoginSignUpScreen/components/GoogleButton.dart';

class LoginBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(top: screenHeight(context) * 0.05),
                child: Logo()),
            SizedBox(height: screenHeight(context) * 0.05),
            Form(child: _main(context)),
            SizedBox(height: screenHeight(context) * 0.075),
            _signUp(context),
            SizedBox(height: screenHeight(context) * 0.025),
          ],
        ),
      ),
    );
  }

  Widget _signUp(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Don't have an account?",
            style: TextStyle(fontSize: 15, color: MyTheme.onPrimaryColor)),
        SizedBox(height: 10),
        MaterialButton(
          onPressed: () {
            router.signUp(context);
          },
          shape: StadiumBorder(),
          color: MyTheme.primaryColor,
          padding: EdgeInsets.fromLTRB(40, 12, 40, 12),
          child: Text('Sign Up',
              style: TextStyle(color: MyTheme.onPrimaryColor, fontSize: 15)),
        )
      ],
    );
  }

  Widget _main(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GoogleButton(
          isSignUp: false,
        ),
        SizedBox(height: 30),
        Center(
          child: Text('Or',
              style: TextStyle(color: MyTheme.onPrimaryColor, fontSize: 25)),
        ),
        SizedBox(height: 30),
        TheForm(
          isSignUp: false,
        )
      ],
    );
  }
}
