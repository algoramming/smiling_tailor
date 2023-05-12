import 'package:flutter/material.dart';

import '../../../../constants/size.dart';
import '../../../../utils/transations/down.to.up.dart';
import '../../provider/authentication.provider.dart';

class AuthAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AuthAppBar(this.notifier, {super.key});

  final AuthProvider notifier;

  @override
  Size get preferredSize => Size.fromHeight(barSize);

  @override
  Widget build(BuildContext context) {
    return DownToUpTransition(
      child: notifier.isSignup
          ? AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => notifier.toggleIsSignup(),
              ),
              title: const Text('Sign up'),
              centerTitle: true,
            )
          : null,
    );
  }
}
