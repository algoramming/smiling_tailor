import 'package:flutter/material.dart' show BorderRadius, CrossAxisAlignment, ElevatedButton, MainAxisAlignment, MainAxisSize, RoundedRectangleBorder;

const appName = 'Smiling Tailor';

const mainEnd = MainAxisAlignment.end;
const mainStart = MainAxisAlignment.start;
const mainCenter = MainAxisAlignment.center;
const mainSpaceEvenly = MainAxisAlignment.spaceEvenly;
const mainSpaceAround = MainAxisAlignment.spaceAround;
const mainSpaceBetween = MainAxisAlignment.spaceBetween;

const crossEnd = CrossAxisAlignment.end;
const crossStart = CrossAxisAlignment.start;
const crossCenter = CrossAxisAlignment.center;
const crossStretch = CrossAxisAlignment.stretch;

const mainMax = MainAxisSize.max;
const mainMin = MainAxisSize.min;

const defPadding = 5.0;
const defDuration = Duration(milliseconds: 350);

Duration kAnimationDuration([double t = 2.5]) => Duration(milliseconds: (t * 1000).toInt());

final roundedButtonStyle = ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: borderRadius15));

final borderRadius10 = BorderRadius.circular(10);
final borderRadius12 = BorderRadius.circular(12);
final borderRadius15 = BorderRadius.circular(15);
final borderRadius30 = BorderRadius.circular(30);

final roundedRectangleBorder10 = RoundedRectangleBorder(borderRadius: borderRadius10);
final roundedRectangleBorder12 = RoundedRectangleBorder(borderRadius: borderRadius12);
final roundedRectangleBorder15 = RoundedRectangleBorder(borderRadius: borderRadius15);
final roundedRectangleBorder30 = RoundedRectangleBorder(borderRadius: borderRadius30);
