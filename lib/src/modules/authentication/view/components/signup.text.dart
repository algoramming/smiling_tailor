import 'package:flutter/material.dart';

import '../../../../config/constants.dart';
import '../../../../utils/extensions/extensions.dart';
import '../../../../utils/transations/down.to.up.dart';
import '../../provider/authentication.provider.dart';

class AuthSignupText extends StatelessWidget {
  const AuthSignupText(this.notifier, {super.key});

  final AuthProvider notifier;

  @override
  Widget build(BuildContext context) {
    return DownToUpTransition(
      child: notifier.isSignup
          ? const SizedBox.shrink()
          : Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                mainAxisAlignment: mainCenter,
                children: [
                  Text(
                    'Don\'t have an account?',
                    style: context.theme.textTheme.titleSmall,
                  ),
                  const SizedBox(width: 5.0),
                  InkWell(
                    onTap: () => notifier.toggleIsSignup(),
                    child: Text(
                      'Create Account',
                      style: context.theme.textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: context.theme.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
