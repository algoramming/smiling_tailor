import 'package:flutter/material.dart';
import 'package:smiling_tailor/src/modules/authentication/provider/authentication.provider.dart';
import 'package:smiling_tailor/src/utils/transations/big.to.small.dart';

class AuthButton extends StatelessWidget {
  const AuthButton(this.notifier, {super.key});

  final AuthProvider notifier;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: BigToSmallTransition(
        child: Text(notifier.isSignup ? 'Sign up' : 'Login'),
      ),
      onPressed: () {},
    );
  }
}
