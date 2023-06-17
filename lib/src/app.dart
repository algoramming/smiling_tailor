import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart'
    show
        BouncingScrollPhysics,
        BuildContext,
        FocusScope,
        GestureDetector,
        Key,
        MaterialApp,
        MediaQuery,
        RangeMaintainingScrollPhysics,
        ScrollBehavior,
        ScrollDecelerationRate,
        ScrollPhysics,
        ScrollableDetails,
        ThemeData,
        Widget;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'
    show AppLocalizations;
import 'package:flutter_riverpod/flutter_riverpod.dart'
    show ConsumerWidget, WidgetRef;
import 'package:smiling_tailor/src/modules/settings/model/locale/locale.model.dart';
import 'package:smiling_tailor/src/modules/settings/model/theme/theme.model.dart';
import 'package:smiling_tailor/src/utils/logger/logger_helper.dart';

import '../beamer.routes.dart';
import 'config/constants.dart' show appName;
import 'config/get.platform.dart';
import 'config/is.under.min.size.dart';
import 'config/screen_enlarge_warning.dart';
import 'config/size.dart';
import 'localization/loalization.dart'
    show localizationsDelegates, onGenerateTitle, t;
import 'modules/home/view/home.view.dart';
import 'modules/settings/provider/fonts.provider.dart';
import 'modules/settings/provider/locale.provider.dart';
import 'modules/settings/provider/performance.overlay.provider.dart';
import 'modules/settings/provider/theme.provider.dart';
import 'utils/extensions/extensions.dart';

class App extends ConsumerWidget {
  const App({super.key = const Key(appName)});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BeamerProvider(
      routerDelegate: routerDelegate,
      child: MaterialApp.router(
        title: appName,
        theme: _themeData(ref),
        routerDelegate: routerDelegate,
        onGenerateTitle: onGenerateTitle,
        debugShowCheckedModeBanner: false,
        // scaffoldMessengerKey: snackbarKey,
        routeInformationParser: BeamerParser(),
        restorationScopeId: appName.toCamelWord,
        locale: ref.watch(localeProvider).locale,
        localizationsDelegates: localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        scrollBehavior: _scrollBehavior.copyWith(scrollbars: false),
        showPerformanceOverlay: ref.watch(performanceOverlayProvider),
        backButtonDispatcher: BeamerBackButtonDispatcher(delegate: routerDelegate),
        builder: EasyLoading.init(builder: (ctx, child) {
          t = AppLocalizations.of(ctx)!;
          topBarSize = ctx.mq.viewPadding.top;
          bottomViewPadding = ctx.mq.viewPadding.bottom;
          log.i('App build. Height: ${ctx.height} px, Width: ${ctx.width} px');
          return MediaQuery(
            data: ctx.mq.copyWith(textScaleFactor: 1.0, devicePixelRatio: 1.0),
            child: isUnderMinSize(ctx.mq.size)
                ? const ScreenEnlargeWarning()
                : child ?? const HomeView(),
          );
        }),
      ),
    );
  }
}

ThemeData _themeData(WidgetRef ref) {
  final t = ref.watch(themeProvider).theme;
  final f = ref.watch(fontProvider);
  return t.copyWith(
    textTheme: t.textTheme.apply(fontFamily: f),
    primaryTextTheme: t.textTheme.apply(fontFamily: f),
  );
}

class HideKeyboardScrollBehavior extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      pt.isDesktop ? _bouncingDesktopPhysics : _bouncingPhysics;

  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return GestureDetector(
      onTap: child.key != null ? null : () => FocusScope.of(context).unfocus(),
      child: child,
    );
  }
}

final _scrollBehavior = HideKeyboardScrollBehavior();

const ScrollPhysics _bouncingPhysics = BouncingScrollPhysics(
  decelerationRate: ScrollDecelerationRate.normal,
  parent: RangeMaintainingScrollPhysics(),
);

const ScrollPhysics _bouncingDesktopPhysics = BouncingScrollPhysics(
  decelerationRate: ScrollDecelerationRate.fast,
  parent: RangeMaintainingScrollPhysics(),
);
