import 'package:flutter/material.dart';

class MyTheme {
  Color darkBackgroundColor = const Color(0xFF131313);
  bool isDark;
  BuildContext context;
  Color onBackgroundColor = const Color(0xFF1B1716);
  static Color get primaryColor => const Color(0xFF38515B);
  static Color get secondaryColor => const Color(0xFF1F5D2F);

  static Color get onPrimaryColor => const Color(0xFFF3F7FB);
  static Color get backgroundColor => const Color(0xFF25252A);
  static Color get barBackgroundColor => const Color(0xFF1B1716);

  static Color get courtColor => const Color(0xFF428E37);

  static Color get smashColor => const Color(0xFFFF3300);
  static Color get dropColor => const Color(0xFF555555);
  static Color get serveColor => const Color(0xFF1F5D2F);
  static Color get clearColor => const Color(0xFF0088A6);
  static Color get driveColor => const Color(0xFFA63C00);

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
      fontFamily: 'PlayFair_Display',
      // buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.accent),
      primaryColor: MyTheme.primaryColor,
      backgroundColor: MyTheme.backgroundColor,
      buttonColor: MyTheme.primaryColor,
      splashColor: MyTheme.secondaryColor,
      iconTheme: IconThemeData(color: Colors.white, opacity: 1.0, size: 33.0),
      textTheme: TextTheme(
          bodyText2: TextStyle(
        color: MyTheme.backgroundColor,
        fontSize: 20.0,
      )),
      visualDensity: VisualDensity.adaptivePlatformDensity);
}
