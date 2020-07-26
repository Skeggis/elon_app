import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class DescriptionText extends StatefulWidget {
  final String text;
  final double fontSize;
  final int maxLines;
  DescriptionText({this.text, this.fontSize = 18, this.maxLines = 4});

  @override
  State<StatefulWidget> createState() {
    return _DescriptionText();
  }
}

class _DescriptionText extends State<DescriptionText> {
  bool isOpened = false;

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      widget.text,
      minFontSize: widget.fontSize,
      maxLines: widget.maxLines,
      
    );
  }
}
