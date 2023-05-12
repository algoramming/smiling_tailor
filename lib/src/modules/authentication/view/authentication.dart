import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiling_tailor/src/modules/authentication/provider/authentication.provider.dart';
import 'package:smiling_tailor/src/modules/authentication/view/components/button.dart';
import 'package:smiling_tailor/src/modules/authentication/view/components/image.select.dart';
import 'package:smiling_tailor/src/modules/authentication/view/components/signup.text.dart';
import 'package:smiling_tailor/src/utils/extensions/extensions.dart';

import '../../../constants/constants.dart';
import '../../settings/view/advance/url.config.tile.dart';
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 5.0,
                child: AnimatedContainer(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 6.0, vertical: 10.0),
                  duration: const Duration(milliseconds: 200),
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
          ),
        ),
      ),
      floatingActionButton: IconButton(
        icon: const Icon(Icons.settings, size: 20.0),
        onPressed: () async => await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const URLConfigPopup(),
        ),
      ),
    );
  }
}
