import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle;

import '../../config/constants.dart';
import '../../db/hive.dart';
import '../../modules/settings/model/settings.model.dart';
import '../../modules/settings/model/theme/theme.model.dart';
import '../extensions/extensions.dart';

String get fontFamily =>
    Boxes.appSettings.get(appName.toCamelWord, defaultValue: AppSettings())!.fontFamily;

ThemeProfile get themeType => Boxes.appSettings
    .get(appName.toCamelWord, defaultValue: AppSettings())!
    .theme;

SystemUiOverlayStyle get uiConfig => themeType.uiConfig;

const Color white = Colors.white;
const Color black = Colors.black;
const Color transparent = Colors.transparent;

const Color kPrimaryColor = Colors.teal;

const defaultGradient = LinearGradient(
  colors: [Color(0xFF5DC095), Color(0xFF1692B6), Color(0xFF2F73B9)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
