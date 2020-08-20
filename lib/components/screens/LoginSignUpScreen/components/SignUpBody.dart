import 'package:flutter/material.dart';
import 'package:myapp/styles/theme.dart';
import 'package:myapp/services/helpers.dart';
import 'package:myapp/components/screens/LoginSignUpScreen/components/TheForm.dart';

import 'package:myapp/components/screens/LoginSignUpScreen/components/GoogleButton.dart';

import 'package:myapp/routes/router.dart' as router;

class SignUpBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: screenHeight(context) * 0.075),
            GoogleButton(
              isSignUp: true,
              onSuccessfulSubmit: () {
                Navigator.of(context).pop();
                router.home(context);
              },
            ),
            SizedBox(height: screenHeight(context) * 0.05),
            Text('Or',
                style: TextStyle(color: MyTheme.onPrimaryColor, fontSize: 25)),
            SizedBox(height: screenHeight(context) * 0.06),
            TheForm(
              onSuccessfulSubmit: () {
                Navigator.of(context).pop();
                router.home(context);
              },
              isSignUp: true,
            )
          ],
        ),
      ),
    );
  }
}
