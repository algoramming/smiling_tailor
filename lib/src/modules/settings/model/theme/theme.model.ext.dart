part of 'theme.model.dart';

extension ThemeProfileExtension on ThemeProfile {
  ThemeData get theme {
    switch (this) {
      case ThemeProfile.dark:
        return darkTheme;
      case ThemeProfile.light:
        return lightTheme;
      default:
        return lightTheme;
    }
  }

  Color get color {
    switch (this) {
      case ThemeProfile.dark:
        return Colors.black;
      case ThemeProfile.light:
        return Colors.white;
      default:
        return Colors.white;
    }
  }

  SystemUiOverlayStyle get uiConfig {
    switch (this) {
      case ThemeProfile.dark:
        return darkUiConfig;
      case ThemeProfile.light:
        return lightUiConfig;
      default:
        return lightUiConfig;
    }
  }

  ThemeProfile get toggled =>
      this == ThemeProfile.light ? ThemeProfile.dark : ThemeProfile.light;
}
