// import 'package:flutter/material.dart'
//     show
//         FadeTransition,
//         GlobalKey,
//         NavigatorState,
//         PageRouteBuilder,
//         Route,
//         RouteSettings;
// import 'package:flutter/services.dart';
// import 'package:smiling_tailor/src/modules/authentication/view/authentication.dart';

// import '../modules/home/view/home.view.dart';
// import '../utils/themes/themes.dart';
// import 'router.dart' show AppRouter;

// final navigatorKey = GlobalKey<NavigatorState>();

// Route<dynamic>? onGenerateRoute(RouteSettings settings) => PageRouteBuilder(
//       settings: settings,
//       transitionDuration: const Duration(milliseconds: 300),
//       transitionsBuilder: (_, animation, __, child) =>
//           FadeTransition(opacity: animation, child: child),
//       pageBuilder: (_, __, ___) {
//         switch (settings.name) {
//           case HomeView.name:
//             changeWebTitle(HomeView.label);
//             return const HomeView();
//           case AuthenticationView.name:
//             changeWebTitle(AuthenticationView.label);
//             return const AuthenticationView();
//           default:
//             changeWebTitle(AppRouter.label);
//             return const AppRouter();
//         }
//       },
//     );


