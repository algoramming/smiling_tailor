import 'package:flutter/material.dart';

Size calculateTextSize(String text, {TextStyle? style, int maxLine = 1}) {
  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: text, style: style),
    textDirection: TextDirection.ltr,
    maxLines: maxLine,
  )..layout(minWidth: 0, maxWidth: double.infinity);
  return textPainter.size;
}
