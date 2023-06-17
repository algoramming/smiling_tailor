import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/get.platform.dart';
import '../../../shared/show_toast/awsome.snackbar/awesome.snackbar.dart';
import '../../../shared/show_toast/awsome.snackbar/show.awesome.snackbar.dart';
import '../enum/home.enum.dart';

typedef HomeNotifier = AutoDisposeNotifierProvider<HomeProvider, void>;

final homeProvider = HomeNotifier(HomeProvider.new);

class HomeProvider extends AutoDisposeNotifier {
  KDrawer _drawer = KDrawer.dashboard;

  @override
  void build() {}

  KDrawer get drawer => _drawer;

  void changeDrawer(BuildContext context, KDrawer drawer) {
    if (drawer == _drawer) return;
    if (drawer.isInvoice && pt.isWeb) {
      showAwesomeSnackbar(
        context,
        'Message',
        'You can\'t see invoices in web.',
        MessageType.help,
      );
      return;
    }
    _drawer = drawer;
    ref.notifyListeners();
  }
}
