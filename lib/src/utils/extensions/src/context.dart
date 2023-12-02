part of '../extensions.dart';

enum ScreenType { mobile, desktop }

extension BuildContextExtension on BuildContext {
  MediaQueryData get mq => MediaQuery.of(this);
  ThemeData get theme => Theme.of(this);

  Size get size => MediaQuery.sizeOf(this);
  EdgeInsets get padding => MediaQuery.viewPaddingOf(this);
  double get height => size.height;
  double get width => size.width;

  bool get tooSmall => width < 350 || height < 500;

  TextTheme get text => theme.textTheme;

  bool get isAndroid => theme.platform == TargetPlatform.android;
  bool get isIOS => theme.platform == TargetPlatform.iOS;
  bool get isWindows => theme.platform == TargetPlatform.windows;
  bool get isLinux => theme.platform == TargetPlatform.linux;
  bool get isMacOS => theme.platform == TargetPlatform.macOS;
  bool get isDesktop => isWindows || isLinux || isMacOS;
  bool get isMobile => isAndroid || isIOS;
  ScreenType get screenType =>
      width > 800 ? ScreenType.desktop : ScreenType.mobile;
  bool get isScreenDesktop => screenType == ScreenType.desktop;

  Future<T?> push<T>(Widget page) =>
      Navigator.of(this).push<T>(MaterialPageRoute(builder: (_) => page));

  Future<T?> pushReplace<T>(Widget page) => Navigator.of(this)
      .pushReplacement<T, T?>(MaterialPageRoute(builder: (_) => page));

  Future<T?> pushRemoveUntil<T>(Widget page) =>
      Navigator.of(this).pushAndRemoveUntil<T>(
          MaterialPageRoute(builder: (_) => page), (_) => false);

  void pop<T>([T? result]) => Navigator.of(this).pop(result);

  Future<T?> pushNamed<T>(String route) =>
      Navigator.of(this).pushNamed<T>(route);

  Future<T?> pushReplaceNamed<T>(String route) =>
      Navigator.of(this).pushReplacementNamed(route);

  Future<T?> pushNamedRemoveUntil<T>(String route) =>
      Navigator.of(this).pushNamedAndRemoveUntil<T>(route, (_) => false);
}

extension NavigatorStateExtension on NavigatorState {
  Future<T?> push<T>(Widget page) =>
      this.push<T>(MaterialPageRoute(builder: (_) => page));

  Future<T?> pushReplace<T>(Widget page) =>
      pushReplacement<T, T?>(MaterialPageRoute(builder: (_) => page));

  Future<T?> pushRemoveUntil<T>(Widget page) => pushAndRemoveUntil<T>(
      MaterialPageRoute(builder: (_) => page), (_) => false);

  void pop<T>([T? result]) => this.pop(result);

  Future<T?> pushNamed<T>(String route) => this.pushNamed<T>(route);

  Future<T?> pushReplaceNamed<T>(String route) => pushReplacementNamed(route);

  Future<T?> pushNamedRemoveUntil<T>(String route) =>
      pushNamedAndRemoveUntil<T>(route, (_) => false);
}

extension BuildContextBeamerExtension on BuildContext {
  BeamerDelegate get beamer => Beamer.of(this);

  void beamPush(String uri) => Beamer.of(this).beamToNamed(uri);

  void beamBack() => Beamer.of(this).beamBack();

  void beamUpdate() => Beamer.of(this).update();

  void beamDoubleBack() {
    Beamer.of(this).beamBack();
    Beamer.of(this).beamBack();
  }

  void beamPushReplacement(String uri) =>
      Beamer.of(this).beamToReplacementNamed(uri);

  void urlHistory() => log.i(
      'Url History: ${Beamer.of(this).beamingHistory.map((e) => e.history.map((v) => v.routeInformation.uri)).toList()}');
}

extension BuildContextBeamerDelegateExtension on BeamerDelegate  {

  void beamPush(String uri) => beamToNamed(uri);

  void beamBack() => beamBack();

  void beamUpdate() => update();

  void beamDoubleBack() {
    beamBack();
    beamBack();
  }

  void beamPushReplacement(String uri) => beamToReplacementNamed(uri);

  void urlHistory() => log.i(
      'Url History: ${beamingHistory.map((e) => e.history.map((v) => v.routeInformation.uri)).toList()}');
}
