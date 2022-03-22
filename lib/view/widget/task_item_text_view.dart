import 'package:flutter/material.dart';

class TaskItemTextView extends StatelessWidget {
  TaskItemTextView(this.text, {
    this.fontWeight,
    this.fontSize,
    this.textAlign,
    required this.maxLines,
    this.isCrossed = false,
    Key? key,
  }) : super(key: key);

  String text;
  FontWeight? fontWeight;
  double? fontSize;
  TextAlign? textAlign;
  int maxLines;
  bool isCrossed;


  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        decoration: isCrossed ? TextDecoration.lineThrough : null,
        color: isCrossed ? Colors.white60 : Colors.white,
        fontWeight: fontWeight,
        fontSize: fontSize,

      ),

    );
  }
}
