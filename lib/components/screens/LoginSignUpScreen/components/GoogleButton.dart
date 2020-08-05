import 'package:flutter/material.dart';
import 'package:myapp/services/models/UserModel.dart';
import 'package:myapp/styles/theme.dart';
import 'package:myapp/routes/router.dart' as router;
import 'package:myapp/services/models/UIModel.dart';

class GoogleButton extends StatelessWidget {
  bool isSignUp = false;

  GoogleButton({this.isSignUp});
  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () async {
        UIModel.of(context).setLoading(true);
        if (this.isSignUp) {
          bool success = await UserModel.of(context).signInWithGoogle();
          if (success) {
            Navigator.of(context).pop();
            router.home(context);
          }
        } else {
          bool success = await UserModel.of(context).signInWithGoogle();
          if (success) {
            router.home(context);
          }
        }
        UIModel.of(context).setLoading(false);
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 3,
      borderSide: BorderSide(color: MyTheme.onPrimaryColor, width: 2),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(25, 17, 25, 17),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
                image: AssetImage("assets/images/google_logo.png"),
                height: 15.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                this.isSignUp ? 'Sign up with Google' : 'Login with Google',
                style: TextStyle(
                  fontSize: 15,
                  color: MyTheme.onPrimaryColor,
                ),
              ),
            ),
            Icon(Icons.play_arrow, size: 15, color: MyTheme.onPrimaryColor)
          ],
        ),
      ),
    );
  }
}
