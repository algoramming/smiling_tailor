import 'package:flutter/material.dart';

import 'body.dart';
import 'clock.dart';
import 'footer.dart';
import 'header.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        KDrawerHeader(),
        ClockWidget(),
        Expanded(child: KDrawerBody()),
        KDrawerFooter(),
      ],
    );
  }
}
