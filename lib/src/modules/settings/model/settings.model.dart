import 'dart:convert' show json;

import '../provider/date.format.provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';

import '../../../db/isar.dart';
import '../provider/currency.format.provider.dart';
import '../provider/time.format.provider.dart';
import 'locale/locale.model.dart';
import 'theme/theme.model.dart';

part 'settings.model.crud.ext.dart';
part 'settings.model.ext.dart';
part 'settings.model.g.dart';

@Collection()
class AppSettings {
  AppSettings();

  final Id id = 0;

  bool firstRun = true;
  String currency = 'BDT';
  bool performanceOverlayEnable = false;
  String dateFormat = dateFormates.first;
  String timeFormat = timeFormates.first;
  DateTime firstRunDateTime = DateTime.now().toUtc();
  String fontFamily = GoogleFonts.nunito().fontFamily!;
  String currencyFormat = currencyFormates.first['format']!;

  @Enumerated(EnumType.name)
  ThemeProfile theme = ThemeProfile.light;
  @Enumerated(EnumType.name)
  LocaleProfile locale = LocaleProfile.english;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'firstRunDateTime': firstRunDateTime.toIso8601String(),
        'performanceOverlayEnable': performanceOverlayEnable,
        'currencyFormat': currencyFormat,
        'dateFormat': dateFormat,
        'timeFormat': timeFormat,
        'fontFamily': fontFamily,
        'locale': locale.name,
        'firstRun': firstRun,
        'currency': currency,
        'theme': theme.name,
        'id': id,
      };

  factory AppSettings.fromJson(String source) =>
      AppSettings.fromRawJson(json.decode(source));

  factory AppSettings.fromRawJson(Map<String, dynamic> json) => AppSettings()
    ..firstRunDateTime = DateTime.parse(json['firstRunDateTime'] as String)
    ..performanceOverlayEnable = json['performanceOverlayEnable'] as bool
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
    ..firstRun = json['firstRun'] as bool;

  @override
  String toString() => toRawJson();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AppSettings && other.id == id;
  }

  @Ignore()
  @override
  int get hashCode => id.hashCode;
}
