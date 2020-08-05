import 'package:flutter/material.dart';
import 'package:myapp/styles/theme.dart';

class CustomInput extends StatefulWidget {
  final Function onFocusLost;
  final Function onTyped;
  final Function onFocusGained;
  final TextInputType keyboardType;
  final TextAlign textAlign;
  final String initialText;

  CustomInput({
    this.onFocusLost,
    this.onTyped,
    this.onFocusGained,
    this.keyboardType = TextInputType.number,
    this.textAlign = TextAlign.center,
    this.initialText = '',
  });

  @override
  State<StatefulWidget> createState() {
    return _CustomInput();
  }
}

class _CustomInput extends State<CustomInput> {
  FocusNode focusNode = FocusNode();
  TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = new TextEditingController(text: widget.initialText);

    if (widget.onTyped != null) {
      controller.addListener(() {
        widget.onTyped(controller);
      });
    }

    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        widget.onFocusLost(controller);
      } else {
        if (widget.onFocusGained != null) {
          widget.onFocusGained(controller);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: MyTheme.secondaryColor),
        ),
      ),
      keyboardType: widget.keyboardType,
      textAlign: widget.textAlign,
      style: TextStyle(
        color: Colors.white,
        fontSize: 24,
      ),
    );
  }
}
