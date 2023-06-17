import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle;

import '../../config/constants.dart';
import '../../db/hive.dart';
import '../../modules/settings/model/settings.model.dart';
import '../../modules/settings/model/theme/theme.model.dart';
import '../extensions/extensions.dart';

String get fontFamily =>
    Boxes.appSettings.get(appName, defaultValue: AppSettings())!.fontFamily;

ThemeProfile get themeType => Boxes.appSettings
    .get(appName.toCamelWord, defaultValue: AppSettings())!
    .theme;

SystemUiOverlayStyle get uiConfig => themeType.uiConfig;

const Color white = Colors.white;
const Color black = Colors.black;

const Color kPrimaryColor = Colors.teal;
