import 'package:flutter/material.dart';

Size screenSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

double screenHeight(BuildContext context,
    {double dividedBy = 1, double reducedBy = 0.0}) {
  return (screenSize(context).height - reducedBy) / dividedBy;
}

double screenWidth(BuildContext context,
    {double dividedBy = 1, double reducedBy = 0.0}) {
  return (screenSize(context).width - reducedBy) / dividedBy;
}

double screenHeightExcludingToolbar(BuildContext context,
    {double dividedBy = 1}) {
  return screenHeight(context, dividedBy: dividedBy, reducedBy: kToolbarHeight);
}

void showSnackBar(BuildContext context, List<String> messages) {
  List<Widget> errorWidgets = [
    for (String message in messages)
      Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(message),
      )
  ];
  Scaffold.of(context).showSnackBar(SnackBar(
    behavior: SnackBarBehavior.floating,
    elevation: 8,
    backgroundColor: const Color(0xFF272120),
    content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [SizedBox(height: 8), ...errorWidgets]),
  ));
}
