import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../../../config/constants.dart';
import '../../../db/hive.dart';
import '../../../pocketbase/auth.store/helpers.dart';
import '../../../utils/extensions/extensions.dart';
import '../provider/currency.format.provider.dart';
import '../provider/date.format.provider.dart';
import '../provider/time.format.provider.dart';
import 'locale/locale.model.dart';
import 'theme/theme.model.dart';

part 'settings.model.crud.ext.dart';
part 'settings.model.ext.dart';
part 'settings.model.g.dart';

@HiveType(typeId: HiveTypes.appSettings)
class AppSettings extends HiveObject {
  AppSettings();

  @HiveField(0)
  bool firstRun = true;
  @HiveField(1)
  String currency = 'BDT';
  @HiveField(2)
  bool useSecureProtocol = kReleaseMode;
  @HiveField(3)
  bool performanceOverlayEnable = false;
  @HiveField(4)
  String dateFormat = dateFormates.first;
  @HiveField(5)
  String timeFormat = timeFormates.first;
  @HiveField(6)
  ThemeProfile theme = ThemeProfile.light;
  @HiveField(7)
  LocaleProfile locale = LocaleProfile.english;
  @HiveField(8)
  DateTime firstRunDateTime = DateTime.now().toUtc();
  @HiveField(9)
  String fontFamily = GoogleFonts.nunito().fontFamily!;
  @HiveField(10)
  String currencyFormat = currencyFormates.first['format']!;
  @HiveField(11)
  String baseUrl = kReleaseMode ? globalBaseUrl : localBaseUrl;
  

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'firstRunDateTime': firstRunDateTime.toIso8601String(),
        'performanceOverlayEnable': performanceOverlayEnable,
        'useSecureProtocol': useSecureProtocol,
        'currencyFormat': currencyFormat,
        'dateFormat': dateFormat,
        'timeFormat': timeFormat,
        'fontFamily': fontFamily,
        'locale': locale.name,
        'firstRun': firstRun,
        'currency': currency,
        'theme': theme.name,
        'baseUrl': baseUrl,
      };

  factory AppSettings.fromJson(String source) =>
      AppSettings.fromRawJson(json.decode(source));

  factory AppSettings.fromRawJson(Map<String, dynamic> json) => AppSettings()
    ..firstRunDateTime = DateTime.parse(json['firstRunDateTime'] as String)
    ..performanceOverlayEnable = json['performanceOverlayEnable'] as bool
    ..useSecureProtocol = json['useSecureProtocol'] as bool
    ..currencyFormat = json['currencyFormat'] as String
    ..locale = LocaleProfile.values.firstWhere(
        (e) => e.name == json['locale'] as String,
        orElse: () => LocaleProfile.english)
    ..theme = ThemeProfile.values.firstWhere(
        (e) => e.name == json['theme'] as String,
        orElse: () => ThemeProfile.light)
    ..dateFormat = json['dateFormat'] as String
    ..timeFormat = json['timeFormat'] as String
    ..fontFamily = json['fontFamily'] as String
    ..currency = json['currency'] as String
    ..baseUrl = json['baseUrl'] as String
    ..firstRun = json['firstRun'] as bool;

  @override
  String toString() => toRawJson();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AppSettings && other.firstRunDateTime == firstRunDateTime;
  }

  @override
  int get hashCode => firstRunDateTime.hashCode;
}
