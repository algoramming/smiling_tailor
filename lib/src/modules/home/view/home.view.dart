import 'package:flutter/material.dart';

import '../../../config/constants.dart';
import 'components/body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const name = '/home';
  static const label = appName;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomeBody(),
    );
  }
}
