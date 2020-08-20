import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

SnackBar createCustomSnackBar({Widget content}) {
  return SnackBar(
    content: Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: content),
    duration: Duration(seconds: 4),
    behavior: SnackBarBehavior.floating,
    action: SnackBarAction(label: null, onPressed: null),
  );
}


