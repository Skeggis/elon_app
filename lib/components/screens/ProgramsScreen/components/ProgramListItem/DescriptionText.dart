import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class DescriptionText extends StatefulWidget {
  final String text;
  final int maxLines;
  final TextStyle style;
  DescriptionText({this.text, this.style, this.maxLines = 4});

  @override
  State<StatefulWidget> createState() {
    return _DescriptionText();
  }
}

class _DescriptionText extends State<DescriptionText> {
  bool isOpened = false;
  int visibleLines;

  @override
  void initState() {
    super.initState();
    visibleLines = widget.maxLines;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          widget.text,
          style: widget.style,
          minFontSize: widget.style.fontSize,
          maxLines: isOpened ? null : visibleLines,
          overflowReplacement: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.text,
                maxLines: widget.maxLines,
                overflow: TextOverflow.ellipsis,
                style: widget.style,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isOpened = !isOpened;
                  });
                },
                child: Text(
                  'Show more',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: widget.style.fontSize
                  ),
                ),
              )
            ],
          ),
        ),
        if (isOpened)
          GestureDetector(
            onTap: () {
              setState(() {
                isOpened = !isOpened;
              });
            },
            child: Text(
              'Show less',
              style: TextStyle(
                color: Colors.blue,
                fontSize: widget.style.fontSize
              ),
            ),
          ),
      ],
    );
  }
}
