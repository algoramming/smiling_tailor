import 'package:beamer/beamer.dart'
    show
        BeamGuard,
        BeamPage,
        BeamPageType,
        BeamerDelegate,
        RoutesLocationBuilder;
import 'package:flutter/widgets.dart' show ValueKey;
import 'package:smiling_tailor/src/config/constants.dart';
import 'package:smiling_tailor/src/modules/authentication/view/authentication.dart';
import 'package:smiling_tailor/src/modules/maintenance.break/maintenance.break.dart';
import 'package:smiling_tailor/src/pocketbase/auth.store/helpers.dart';
import 'package:smiling_tailor/src/shared/page_not_found/page_not_found.dart';

import 'app.routes.dart';
import 'src/modules/home/view/home.view.dart';

final routerDelegate = BeamerDelegate(
  initialPath: AppRoutes.homeRoute,
  notFoundPage: const BeamPage(
    title: 'Page not found - $appName',
    child: KPageNotFound(error: '404 - Page not found!'),
  ),
  locationBuilder: RoutesLocationBuilder(
    routes: {
      AppRoutes.homeRoute: (_, __, ___) {
        return const BeamPage(
          key: ValueKey(AppRoutes.homeRoute),
          title: appName,
          type: BeamPageType.fadeTransition,
          child: HomeView(),
        );
      },
      AppRoutes.signinRoute: (_, __, ___) {
        return const BeamPage(
          key: ValueKey(AppRoutes.signinRoute),
          title: '$appName - Signin',
          type: BeamPageType.fadeTransition,
          child: AuthenticationView(),
        );
      },
      AppRoutes.maintenanceBreakRoute: (_, __, ___) {
        return const BeamPage(
          key: ValueKey(AppRoutes.maintenanceBreakRoute),
          title: '$appName - Maintenance break',
          type: BeamPageType.fadeTransition,
          child: MaintenanceBreak(),
        );
      },
      AppRoutes.serverDisconnectedRoute: (_, __, ___) {
        return const BeamPage(
          key: ValueKey(AppRoutes.serverDisconnectedRoute),
          title: '$appName - Server disconnected',
          type: BeamPageType.fadeTransition,
          child: KServerNotRunning(),
        );
      },
    },
  ),
  guards: [
    BeamGuard(
      pathPatterns: AppRoutes.allRoutes,
      check: (_, __) => !AppRoutes.isMaintenanceBreak,
      beamToNamed: (_, __) => AppRoutes.maintenanceBreakRoute,
    ),
    BeamGuard(
      pathPatterns: [AppRoutes.maintenanceBreakRoute],
      check: (_, __) => AppRoutes.isMaintenanceBreak,
      beamToNamed: (_, __) => AppRoutes.homeRoute,
    ),
    BeamGuard(
      pathPatterns: AppRoutes.allRoutes,
      check: (_, __) => isServerRunning,
      beamToNamed: (_, __) => AppRoutes.serverDisconnectedRoute,
    ),
    BeamGuard(
      pathPatterns: [AppRoutes.serverDisconnectedRoute],
      check: (_, __) => !isServerRunning,
      beamToNamed: (_, __) => AppRoutes.homeRoute,
    ),
    BeamGuard(
      pathPatterns: AppRoutes.allAuthRequiredRoutes,
      check: (_, __) => pb.authStore.isValid,
      beamToNamed: (_, __) => AppRoutes.signinRoute,
    ),
    BeamGuard(
      pathPatterns: [AppRoutes.signinRoute],
      check: (_, __) => !pb.authStore.isValid,
      beamToNamed: (_, __) => AppRoutes.homeRoute,
    ),
  ],
);
