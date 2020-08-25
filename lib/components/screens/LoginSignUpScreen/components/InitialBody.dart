import 'package:flutter/material.dart';
import 'package:myapp/services/models/scopedModels/UserModel.dart';
import 'package:myapp/components/Logo/Logo.dart';
import 'package:myapp/styles/theme.dart';
import 'package:myapp/services/helpers.dart';
import 'package:myapp/routes/router.dart' as router;

import 'package:myapp/components/screens/LoginSignUpScreen/components/TheForm.dart';
import 'package:myapp/components/screens/LoginSignUpScreen/components/GoogleButton.dart';

import 'package:myapp/components/NormalButton/NormalButton.dart';

import 'package:myapp/services/UsersPreferences.dart';

class InitialBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Stack(
        children: <Widget>[
          Align(alignment: Alignment(0.0, -0.8), child: Logo()),
          Align(
              alignment: Alignment(0.0, 0.1),
              child: Form(child: _main(context))),
          Align(alignment: Alignment(0.0, 0.95), child: _signUp(context)),
        ],
      ),
    );
  }

  Widget _signUp(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {
            UsersPreferences.setUsersUUID('NOT_AN_ACCOUNT');
            router.home(context);
          },
          child: Padding(
            padding: EdgeInsets.all(25),
            child: Text("Use without account",
                style: TextStyle(
                    fontSize: 17, color: Theme.of(context).accentColor)),
          ),
        ),
      ],
    );
  }

  Widget _main(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: screenWidth(context) * 0.17,
          right: screenWidth(context) * 0.17),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 30),
          GoogleButton(
            isSignUp: false,
            onSuccessfulSubmit: () => router.home(context),
          ),
          SizedBox(height: screenHeight(context) * 0.15),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: NormalButton(
                fillColor: Theme.of(context).primaryColor,
                title: "Login with account",
                onPressed: () => router.login(context)),
          ),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: NormalButton(
              fillColor: Theme.of(context).primaryColor,
              title: "Sign up",
              onPressed: () => router.signUp(context),
            ),
          ),
        ],
      ),
    );
  }
}
