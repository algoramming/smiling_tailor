class AppRoutes {
  ///
  /// isMaintenanceBreak is a global variable that is set to true when the app
  static const isMaintenanceBreak = false;

  ///
  static const String homeRoute = '/';
  static const String signinRoute = '/signin';
  static const String maintenanceBreakRoute = '/maintenance-break';
  static const String serverDisconnectedRoute = '/server-disconnected';

  static const List<String> allRoutes = [
    homeRoute,
    signinRoute,
  ];

  static final List<String> allAuthRequiredRoutes = [...allRoutes]
    ..remove(signinRoute);
}
