import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/constants.dart';
import '../../../utils/extensions/extensions.dart';
import '../../../utils/transations/big.to.small.dart';
import '../provider/profile.provider.dart';
import 'components/button.dart';
import 'components/form.dart';
import 'components/image.select.dart';

class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(profileProvider);
    final notifier = ref.read(profileProvider.notifier);
    return Scaffold(
      body: SafeArea(
        child: Center(
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
                        ProfileImage(notifier),
                        ProfileForm(notifier),
                        ProfileButton(notifier),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: ElevatedButton.icon(
        label: BigToSmallTransition(
            child: !notifier.isEditable
                ? Text(
                    'Tap to Editing Mode',
                    style:
                        context.text.labelLarge!.copyWith(color: Colors.white),
                  )
                : Text(
                    'Tap to View Mode',
                    style:
                        context.text.labelLarge!.copyWith(color: Colors.white),
                  )),
        icon: BigToSmallTransition(
          child: !notifier.isEditable
              ? const Icon(Icons.edit, size: 16.0)
              : const Icon(Icons.remove_red_eye, size: 16.0),
        ),
        style: context.theme.elevatedButtonTheme.style!.copyWith(
            minimumSize: MaterialStateProperty.all(const Size(200, 45))),
        onPressed: () => notifier.toggleEditable(),
      ),
    );
  }
}
