import 'package:flutter/material.dart'
    show
        FadeTransition,
        GlobalKey,
        NavigatorState,
        PageRouteBuilder,
        Route,
        RouteSettings;
import 'package:flutter/services.dart';

import '../modules/about_us/about_us.dart';
import '../modules/home/view/home.view.dart';
import '../modules/settings/view/setting.view.dart';
import '../utils/themes/themes.dart';
import 'router.dart' show AppRouter;

final navigatorKey = GlobalKey<NavigatorState>();

Route<dynamic>? onGenerateRoute(RouteSettings settings) => PageRouteBuilder(
      settings: settings,
      transitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (_, animation, __, child) =>
          FadeTransition(opacity: animation, child: child),
      pageBuilder: (_, __, ___) {
        switch (settings.name) {
          case HomeView.name:
            changeWebTitle(HomeView.label);
            return const HomeView();
          case SettingsView.name:
            changeWebTitle(SettingsView.label);
            return const SettingsView();
          case AboutUsView.name:
            changeWebTitle(AboutUsView.label);
            return const AboutUsView();
          default:
            changeWebTitle(AppRouter.label);
            return const AppRouter();
        }
      },
    );

changeWebTitle(String label) {
  SystemChrome.setApplicationSwitcherDescription(ApplicationSwitcherDescription(
      label: label, primaryColor: primaryColor.value));
}
