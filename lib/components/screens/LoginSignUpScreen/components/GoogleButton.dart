import 'package:flutter/material.dart';
import 'package:myapp/services/models/UserModel.dart';
import 'package:myapp/styles/theme.dart';
import 'package:myapp/routes/router.dart' as router;
import 'package:myapp/services/models/UIModel.dart';

class GoogleButton extends StatelessWidget {
  bool isSignUp = false;
  Function onSuccessfulSubmit;

  GoogleButton({this.isSignUp, this.onSuccessfulSubmit});
  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () async {
        UIModel.of(context).setLoading(true);
        bool success = await UserModel.of(context).signInWithGoogle();
        if (success && this.onSuccessfulSubmit != null) {
          this.onSuccessfulSubmit();
        }
        UIModel.of(context).setLoading(false);
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 3,
      borderSide: BorderSide(color: MyTheme.onPrimaryColor, width: 2),
      padding: const EdgeInsets.fromLTRB(27, 17, 27, 17),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(
              image: AssetImage("assets/images/google_logo.png"), height: 15.0),
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
    );
  }
}
