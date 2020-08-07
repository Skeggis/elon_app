import 'package:flutter/material.dart';
import 'package:myapp/styles/theme.dart';

class MessageDialog extends StatelessWidget{
  final String title;
  final String message;
  final Function handleClose;
  
  MessageDialog({this.title, this.message, this.handleClose});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(title),
        content:Text(message, style: TextStyle(fontSize: 16)),
        actions: <Widget>[
          FlatButton(
            child: Text('OK',
                style: TextStyle(color: Theme.of(context).accentColor, fontSize: 18)),
            onPressed: handleClose,
          ),
        ],
      );
  }
}