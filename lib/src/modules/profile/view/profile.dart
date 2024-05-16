import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/constants.dart';
import '../../../shared/loading_widget/loading_widget.dart';
import '../../../shared/page_not_found/page_not_found.dart';
import '../../../utils/extensions/extensions.dart';
import '../../../utils/transations/fade.switcher.dart';
import '../../authentication/model/user.dart';
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
    if (notifier.user == null) return const LoadingWidget();
    if (notifier.user?.isDispose ?? true) return const AccesDeniedPage();
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
                        Container(
                          margin: const EdgeInsets.only(bottom: 10.0),
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            color: notifier.user?.type.color.withOpacity(0.3),
                            borderRadius: borderRadius30,
                            border: Border.all(
                                color: notifier.user?.type.color ??
                                    context.theme.primaryColor,
                                width: 1.5),
                          ),
                          child: Text(
                            notifier.user?.type.title ?? '...',
                            style: context.text.labelMedium,
                          ),
                        ),
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
        label: FadeSwitcherTransition(
          child: !notifier.isEditable
              ? Text(
                  'Tap to Editing Mode',
                  style: context.text.labelLarge!.copyWith(color: Colors.white),
                )
              : Text(
                  'Tap to View Mode',
                  style: context.text.labelLarge!.copyWith(color: Colors.white),
                ),
        ),
        icon: FadeSwitcherTransition(
          child: !notifier.isEditable
              ? const Icon(Icons.edit, size: 16.0)
              : const Icon(Icons.remove_red_eye, size: 16.0),
        ),
        style: context.theme.elevatedButtonTheme.style!.copyWith(
            minimumSize: WidgetStateProperty.all(const Size(200, 45))),
        onPressed: () => notifier.toggleEditable(),
      ),
    );
  }
}
