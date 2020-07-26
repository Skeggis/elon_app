import 'package:flutter/material.dart';

class ProgramListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(4),
        ),
        boxShadow: [
          BoxShadow(blurRadius: 10, color: Colors.grey, spreadRadius: 5),
        ],
      ),
    );
  }
}
