import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

import '../../../../db/hive.dart';
import '../../../../utils/themes/dark/dark.theme.dart';
import '../../../../utils/themes/light/light.theme.dart';

part 'theme.model.ext.dart';

@HiveType(typeId: HiveTypes.themeProfile)
enum ThemeProfile {
  @HiveField(0)
  dark,
  @HiveField(1)
  light,
}
