import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../enum/home.enum.dart';

typedef HomeNotifier = AutoDisposeNotifierProvider<HomeProvider, void>;

final homeProvider = HomeNotifier(HomeProvider.new);

class HomeProvider extends AutoDisposeNotifier {
  KDrawer _drawer = KDrawer.dashboard;

  @override
  void build() {}

  KDrawer get drawer => _drawer;

  void changeDrawer(KDrawer drawer) {
    _drawer = drawer;
    ref.notifyListeners();
  }
}
