import 'package:flutter/material.dart';

const primaryColor = const Color(0xFF38515B);
const backgroundColor = const Color(0xFFF3F7FB);
const secondaryColor = const Color(0xFF25252A);
const darkBackgroundColor = const Color(0xFF131313);
const additionalColor = const Color(0xFF1F5D2F);
const onBackgroundColor = const Color(0xFF1B1716);

class MyTheme {
  Color darkBackgroundColor = const Color(0xFF131313);
  bool isDark;
  BuildContext context;
  Color onBackgroundColor = const Color(0xFF1B1716);
  Color secondaryColor = const Color(0xFF25252A);

  /// Default constructor
  MyTheme({@required this.isDark, @required this.context});

  ThemeData get themeData {
    /// Now that we have ColorScheme and TextTheme, we can create the ThemeData
    var t = appTheme(context);

    /// Return the themeData which MaterialApp can now use
    return t;
  }
}

ThemeData appTheme(context) {
  return ThemeData(
      // buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.accent),
      primaryColor: primaryColor,
      backgroundColor: backgroundColor,
      buttonColor: primaryColor,
      splashColor: secondaryColor,
      iconTheme: IconThemeData(color: Colors.white, opacity: 1.0, size: 33.0),
      textTheme: TextTheme(
          bodyText2: TextStyle(
        color: backgroundColor,
        fontSize: 20.0,
      )),
      visualDensity: VisualDensity.adaptivePlatformDensity);
}
