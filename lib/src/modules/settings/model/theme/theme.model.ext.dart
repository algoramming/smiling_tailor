part of 'theme.model.dart';

extension ThemeProfileExtension on ThemeProfile {
  ThemeData get theme {
    switch (this) {
      case ThemeProfile.blue:
        return blueTheme;
      case ThemeProfile.dark:
        return darkTheme;
      case ThemeProfile.light:
        return lightTheme;
      case ThemeProfile.maroon:
        return maroonTheme;
      case ThemeProfile.pink:
        return pinkTheme;
      case ThemeProfile.yellow:
        return yellowTheme;
      default:
        return lightTheme;
    }
  }

  Color get color {
    switch (this) {
      case ThemeProfile.blue:
        return Colors.blue;
      case ThemeProfile.dark:
        return Colors.black;
      case ThemeProfile.light:
        return Colors.white;
      case ThemeProfile.maroon:
        return Colors.red[900]!;
      case ThemeProfile.pink:
        return Colors.pink;
      case ThemeProfile.yellow:
        return Colors.yellow;
      default:
        return Colors.white;
    }
  }

  SystemUiOverlayStyle get uiConfig {
    switch (this) {
      case ThemeProfile.blue:
        return blueUiConfig;
      case ThemeProfile.dark:
        return darkUiConfig;
      case ThemeProfile.light:
        return lightUiConfig;
      case ThemeProfile.maroon:
        return maroonUiConfig;
      case ThemeProfile.pink:
        return pinkUiConfig;
      case ThemeProfile.yellow:
        return yellowUiConfig;
      default:
        return lightUiConfig;
    }
  }
}
