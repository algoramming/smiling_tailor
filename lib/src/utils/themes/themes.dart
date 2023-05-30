import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle;
import 'package:google_fonts/google_fonts.dart';

import '../../db/isar.dart';
import '../../modules/settings/model/settings.model.dart';
import '../../modules/settings/model/theme/theme.model.dart';

final fontFamily =
    db.appSettings.getSync(0)?.fontFamily ?? GoogleFonts.nunito().fontFamily;

final themeType = db.appSettings.getSync(0)?.theme ?? ThemeProfile.light;

SystemUiOverlayStyle get uiConfig => themeType.uiConfig;

const Color white = Colors.white;
const Color black = Colors.black;

const Color kPrimaryColor = Colors.teal;
