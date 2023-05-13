import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../enum/home.enum.dart';
import '../../../../utils/transations/big.to.small.dart';

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
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: BigToSmallTransition(child: notifier.drawer.widget),
    );
  }
}
