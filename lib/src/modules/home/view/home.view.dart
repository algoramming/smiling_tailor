import 'package:flutter/material.dart';
import 'package:smiling_tailor/src/utils/extensions/extensions.dart';

import '../../../constants/constants.dart';
import '../../settings/view/setting.view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const name = '/home';
  static const label = appName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(appName)),
      body: const Center(child: Text('Hello World!')),
      floatingActionButton: FloatingActionButton.small(
        child: const Icon(Icons.settings),
        onPressed: () => context.pushNamed(SettingsView.name),
      ),
    );
  }
}
