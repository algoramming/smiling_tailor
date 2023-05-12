import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        '$appName - Profile',
        textAlign: TextAlign.center,
      ),
    );
  }
}
