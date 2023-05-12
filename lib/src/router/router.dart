import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../pocketbase/auth.store/helpers.dart';
import '../utils/extensions/extensions.dart';

import '../constants/constants.dart';
import '../constants/is.under.min.size.dart';
import '../constants/screen_enlarge_warning.dart';
import '../modules/authentication/view/authentication.dart';
import '../modules/home/view/home.view.dart';
import '../shared/error_widget/error_widget.dart';
import '../shared/loading_widget/loading_widget.dart';
import '../utils/logger/logger_helper.dart';
import 'provider/data_load_provider.dart';
import 'routes.dart';

class AppRouter extends ConsumerWidget {
  const AppRouter({super.key});

  static const name = '/';
  static const label = appName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!pb.authStore.isValid) return const AuthenticationView();
    if (isUnderMinSize(context.mq.size)) return const ScreenEnlargeWarning();
    return ref.watch(initialDataLoadProvider).when(
          error: (err, _) => KErrorWidget(error: err),
          loading: () => const LoadingWidget(text: 'Initializing...'),
          data: (_) => const HomeView(),
        );
  }
}

class AppRouteObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    final c = route.settings.name;
    final p = previousRoute?.settings.name;
    log.wtf('didPush: $p -> $c');
    // checkGuards(c);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute == null) {
      navigatorKey.currentState
          ?.pushNamedAndRemoveUntil(HomeView.name, (_) => false);
    }
    final c = route.settings.name;
    final p = previousRoute?.settings.name;
    log.wtf('didPop: $p -> $c');
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    final c = route.settings.name;
    final p = previousRoute?.settings.name;
    log.wtf('didRemove: $p -> $c');
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    final c = newRoute?.settings.name;
    final p = oldRoute?.settings.name;
    log.wtf('didReplace: $p -> $c');
  }

  @override
  void didStartUserGesture(Route route, Route? previousRoute) {
    super.didStartUserGesture(route, previousRoute);
    final c = route.settings.name;
    final p = previousRoute?.settings.name;
    log.wtf('didStartUserGesture: $p -> $c');
  }

  @override
  void didStopUserGesture() {
    super.didStopUserGesture();
    log.wtf('didStopUserGesture');
  }
}

const authRequiredRoutes = <String>[
  '/',
  HomeView.name,
];

const authNotRequiredRoutes = <String>[
  AuthenticationView.name,
];

void checkGuards(String? route) {
  log.e('checkGuards: $route');
  if (authRequiredRoutes.contains(route)) {
    if (!pb.authStore.isValid) {
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        AuthenticationView.name,
        (_) => false,
      );
    }
  }
  if (authNotRequiredRoutes.contains(route)) {
    if (pb.authStore.isValid) {
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        HomeView.name,
        (_) => false,
      );
    }
  }
}
