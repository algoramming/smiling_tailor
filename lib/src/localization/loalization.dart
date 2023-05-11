import 'package:flutter/material.dart' show BuildContext, Locale;
import 'package:flutter_gen/gen_l10n/app_localizations.dart'
    show AppLocalizations;
import 'package:flutter_localizations/flutter_localizations.dart'
    show
        GlobalCupertinoLocalizations,
        GlobalMaterialLocalizations,
        GlobalWidgetsLocalizations;

late AppLocalizations t;

const localizationsDelegates = [
  AppLocalizations.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];

String onGenerateTitle(BuildContext context) =>
    AppLocalizations.of(context)!.appTitle;

const supportedLocales = [
  arLocale,
  bnLocale,
  enLocale,
  hiLocale,
  urLocale,
];

const arLocale = Locale('ar', 'AE');
const bnLocale = Locale('bn', 'BD');
const enLocale = Locale('en', 'US');
const hiLocale = Locale('hi', 'IN');
const urLocale = Locale('ur', 'PK');
