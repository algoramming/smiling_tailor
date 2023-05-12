import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiling_tailor/src/modules/home/enum/home.enum.dart';

typedef HomeNotifier = NotifierProvider<HomeProvider, void>;

final homeProvider = HomeNotifier(HomeProvider.new);

class HomeProvider extends Notifier {
  KDrawer _drawer = KDrawer.dashboard;

  @override
  void build() {}

  KDrawer get drawer => _drawer;

  void changeDrawer(KDrawer drawer) {
    _drawer = drawer;
    ref.notifyListeners();
  }
}
