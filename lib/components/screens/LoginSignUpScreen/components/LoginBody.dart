import 'package:flutter/material.dart';
import 'package:myapp/services/models/UserModel.dart';
import 'package:myapp/components/Logo/Logo.dart';
import 'package:myapp/styles/theme.dart';
import 'package:myapp/services/helpers.dart';
import 'package:myapp/routes/router.dart' as router;

import 'package:myapp/components/screens/LoginSignUpScreen/components/TheForm.dart';
import 'package:myapp/components/screens/LoginSignUpScreen/components/GoogleButton.dart';
import 'package:myapp/routes/router.dart' as router;

class LoginBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: Stack(
        children: <Widget>[
          Align(alignment: Alignment(0.0, -0.9), child: Logo()),
          Align(
              alignment: Alignment.center, child: Form(child: _main(context))),
        ],
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
        SizedBox(height: 30),
        TheForm(
          onSuccessfulSubmit: () {
            Navigator.of(context).pop();
            router.home(context);
          },
          isSignUp: false,
        )
      ],
    );
  }
}
