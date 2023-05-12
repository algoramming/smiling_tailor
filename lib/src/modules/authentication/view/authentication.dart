import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiling_tailor/src/modules/authentication/provider/authentication.provider.dart';
import 'package:smiling_tailor/src/modules/authentication/view/components/button.dart';
import 'package:smiling_tailor/src/modules/authentication/view/components/image.select.dart';
import 'package:smiling_tailor/src/modules/authentication/view/components/signup.text.dart';
import 'package:smiling_tailor/src/utils/extensions/extensions.dart';

import '../../../constants/constants.dart';
import 'components/app.bar.dart';
import 'components/form.dart';

class AuthenticationView extends ConsumerWidget {
  const AuthenticationView({super.key});

  static const name = '/authentication';
  static const label = 'Authentication - $appName';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(authProvider);
    final notifier = ref.read(authProvider.notifier);
    return Scaffold(
      appBar: AuthAppBar(notifier),
      body: Center(
        child: SizedBox(
          width: min(400, context.width),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: mainMin,
              children: [
                AuthImageSelect(notifier),
                AuthForm(notifier),
                AuthSignupText(notifier),
                AuthButton(notifier),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
