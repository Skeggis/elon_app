import 'package:flutter/material.dart';
import 'package:myapp/styles/theme.dart';
import 'package:myapp/services/models/UserModel.dart';
import 'package:myapp/routes/Routes.dart';
import 'package:myapp/routes/router.dart' as router;
import 'package:myapp/services/models/UIModel.dart';

class TheForm extends StatefulWidget {
  bool isSignUp;
  TheForm({this.isSignUp = false});
  @override
  State<StatefulWidget> createState() => _TheForm();
}

class _TheForm extends State<TheForm> {
  bool _passwordVisible;
  bool _confirmPasswordVisible;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  FocusNode confirmPassFocus;

  void initState() {
    super.initState();

    setState(() {
      _passwordVisible = false;
      _confirmPasswordVisible = false;

      confirmPassFocus = FocusNode();
    });
  }

  Widget _snackBar(List<String> messages) {
    List<Widget> errorWidgets = [
      for (String message in messages)
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(message),
        )
    ];
    return SnackBar(
      behavior: SnackBarBehavior.floating,
      elevation: 8,
      backgroundColor: const Color(0xFF272120),
      content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [SizedBox(height: 8), ...errorWidgets]),
    );
  }

  @override
  void dispose() {
    confirmPassFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("HEREBOYD");
    List<String> errors = UserModel.of(context, rebuildOnChange: true).errors;
    print(errors);

    if (errors.length > 0 &&
        ((ModalRoute.of(context).settings.name == Routes.root &&
                !widget.isSignUp) ||
            (widget.isSignUp))) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        var snackBar = _snackBar(errors);
        Scaffold.of(context).showSnackBar(snackBar);
        UserModel.of(context).cleanUpErrors();
      });

      // errors.map((error) {

      // });
    }
    return Form(
      child: Padding(
        padding: const EdgeInsets.only(left: 50, right: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextFormField(
              controller: emailController,
              // controller: controller,
              style: TextStyle(color: MyTheme.onPrimaryColor, fontSize: 15),
              cursorColor: MyTheme.onPrimaryColor.withOpacity(0.5),
              textAlign: TextAlign.left,
              onEditingComplete: () => FocusScope.of(context).nextFocus(),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  prefixIcon: Icon(Icons.mail,
                      color: MyTheme.onPrimaryColor.withOpacity(0.75)),
                  fillColor: const Color(0xFF272120),
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(5)),
                  hintText: "Email",
                  hintStyle: TextStyle(
                      fontSize: 17,
                      color: MyTheme.onPrimaryColor.withOpacity(0.5))),
            ),
            SizedBox(height: 15),
            TextFormField(
              obscureText: !_passwordVisible,
              controller: passwordController,
              style: TextStyle(color: MyTheme.onPrimaryColor, fontSize: 15),
              cursorColor: MyTheme.onPrimaryColor.withOpacity(0.5),
              textAlign: TextAlign.left,
              onEditingComplete: () {
                if (widget.isSignUp) {
                  confirmPassFocus.requestFocus();
                } else {
                  FocusScope.of(context).nextFocus();
                }
              },
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    splashColor: Colors.transparent,
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: MyTheme.onPrimaryColor.withOpacity(0.75),
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                  contentPadding: EdgeInsets.all(0),
                  prefixIcon: Icon(Icons.lock,
                      color: MyTheme.onPrimaryColor.withOpacity(0.75)),
                  fillColor: const Color(0xFF272120),
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(5)),
                  hintText: "Password",
                  hintStyle: TextStyle(
                      fontSize: 17,
                      color: MyTheme.onPrimaryColor.withOpacity(0.5))),
            ),
            SizedBox(height: 15),
            widget.isSignUp
                ? TextFormField(
                    focusNode: confirmPassFocus,
                    obscureText: !_confirmPasswordVisible,
                    controller: confirmPasswordController,
                    style:
                        TextStyle(color: MyTheme.onPrimaryColor, fontSize: 15),
                    cursorColor: MyTheme.onPrimaryColor.withOpacity(0.5),
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          splashColor: Colors.transparent,
                          icon: Icon(
                            _confirmPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: MyTheme.onPrimaryColor.withOpacity(0.75),
                          ),
                          onPressed: () {
                            setState(() {
                              _confirmPasswordVisible =
                                  !_confirmPasswordVisible;
                            });
                          },
                        ),
                        contentPadding: EdgeInsets.all(0),
                        prefixIcon: Icon(Icons.lock,
                            color: MyTheme.onPrimaryColor.withOpacity(0.75)),
                        fillColor: const Color(0xFF272120),
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(5)),
                        hintText: "Confirm Password",
                        hintStyle: TextStyle(
                            fontSize: 17,
                            color: MyTheme.onPrimaryColor.withOpacity(0.5))),
                  )
                : SizedBox(height: 0),
            widget.isSignUp ? SizedBox(height: 25) : SizedBox(height: 0),
            MaterialButton(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                color: MyTheme.primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                onPressed: () async {
                  print(
                      "${emailController.text} ${passwordController.text} ${confirmPasswordController.text}");

                  if (widget.isSignUp) {
                    if (emailController.text == '' ||
                        passwordController.text == '' ||
                        confirmPasswordController.text == '') {
                      var snackBar = _snackBar(
                          ['Please fill in all fields before submitting']);
                      Scaffold.of(context).showSnackBar(snackBar);
                      return false;
                    }

                    bool isEmailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(emailController.text);
                    if (!isEmailValid) {
                      return Scaffold.of(context).showSnackBar(
                          _snackBar(['Please enter a valid email']));
                    }

                    if (passwordController.text.length < 10) {
                      return Scaffold.of(context).showSnackBar(_snackBar([
                        'Please enter a password that is at least 10 letters'
                      ]));
                    }

                    if (passwordController.text !=
                        confirmPasswordController.text) {
                      return Scaffold.of(context).showSnackBar(
                          _snackBar(['The passwords do not match']));
                    }

                    UIModel.of(context).setLoading(true);
                    bool success = await UserModel.of(context).signUp(
                        emailController.text,
                        passwordController.text,
                        confirmPasswordController.text);
                    UIModel.of(context).setLoading(false);

                    if (success) {
                      Navigator.of(context).pop();
                      router.home(context);
                    }
                  } else {
                    if (emailController.text == '' ||
                        passwordController.text == '') {
                      var snackBar = _snackBar(
                          ['Please fill in all fields before submitting']);
                      Scaffold.of(context).showSnackBar(snackBar);
                      return false;
                    }
                    UIModel.of(context).setLoading(true);
                    bool success = await UserModel.of(context)
                        .login(emailController.text, passwordController.text);
                    UIModel.of(context).setLoading(false);
                    if (success) {
                      router.home(context);
                    }
                  }
                },
                child: Text(widget.isSignUp ? 'Sign Up' : 'Login',
                    style: TextStyle(
                        color: MyTheme.onPrimaryColor, fontSize: 17))),
          ],
        ),
      ),
    );
  }
}
