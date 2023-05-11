import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({super.key});

  static const name = '/about-us';
  static const label = 'About Us - $appName';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About Us')),
      body: const Center(
        child: Text(
          '$appName - About Us',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
