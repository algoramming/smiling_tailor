import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../profile/provider/profile.provider.dart';
import '../../../../shared/loading_widget/loading_widget.dart';

import '../../../../utils/transations/fade.switcher.dart';
import '../../enum/home.enum.dart';
import '../../provider/home.provider.dart';
import 'drawer/drawer.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Row(
        children: [
          Expanded(flex: 2, child: AppDrawer()),
          Expanded(flex: 9, child: MainBody()),
        ],
      ),
    );
  }
}

class MainBody extends ConsumerWidget {
  const MainBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(homeProvider);
    final notifier = ref.read(homeProvider.notifier);
    final user = ref.watch(profileProvider);
    if (user == null) return const LoadingWidget();
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: FadeSwitcherTransition(child: notifier.drawer.widget),
    );
  }
}
