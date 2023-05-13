import 'package:flutter/material.dart';

import '../../../../utils/extensions/extensions.dart';
import '../../../../utils/transations/big.to.small.dart';
import '../../provider/authentication.provider.dart';

class AuthButton extends StatelessWidget {
  const AuthButton(this.notifier, {super.key});

  final AuthProvider notifier;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: ElevatedButton(
        style: context.theme.elevatedButtonTheme.style!.copyWith(
            minimumSize: MaterialStateProperty.all(const Size(180, 45))),
        child: BigToSmallTransition(
          child: Text(notifier.isSignup ? 'Create Account' : 'Login'),
        ),
        onPressed: () async => await notifier.submit(context),
      ),
    );
  }
}
