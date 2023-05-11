part of 'locale.model.dart';

extension LocaleProfileExtension on LocaleProfile {
  Locale get locale {
    switch (this) {
      case LocaleProfile.arabic:
        return arLocale;
      case LocaleProfile.bengali:
        return bnLocale;
      case LocaleProfile.english:
        return enLocale;
      case LocaleProfile.hindi:
        return hiLocale;
      case LocaleProfile.urdu:
        return urLocale;
      default:
        return enLocale;
    }
  }

  String get localeName {
    switch (this) {
      case LocaleProfile.arabic:
        return 'Arabic';
      case LocaleProfile.bengali:
        return 'Bengali';
      case LocaleProfile.english:
        return 'English';
      case LocaleProfile.hindi:
        return 'Hindi';
      case LocaleProfile.urdu:
        return 'Urdu';
      default:
        return 'English';
    }
  }
}
