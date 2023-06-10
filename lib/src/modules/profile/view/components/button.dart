import 'package:flutter/material.dart';

import '../../../../shared/animations_widget/animated_popup.dart';
import '../../../../utils/extensions/extensions.dart';
import '../../../../utils/transations/big.to.small.dart';
import '../../../authentication/api/authentication.api.dart';
import '../../provider/profile.provider.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton(this.notifier, {super.key});

  final ProfileProvider notifier;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: ElevatedButton(
        style: context.theme.elevatedButtonTheme.style!.copyWith(
            minimumSize: MaterialStateProperty.all(const Size(180, 45))),
        child: BigToSmallTransition(
            child: notifier.isEditable
                ? const Text('Update Profile')
                : const Text('Reset Password')),
        onPressed: () async => notifier.isEditable
            ? await notifier.submit(context)
            : await showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) =>
                    ConfirmationSendPopup(notifier.user?.email ?? '')),
      ),
    );
  }
}

class ConfirmationSendPopup extends StatelessWidget {
  const ConfirmationSendPopup(this.email, {super.key});

  final String email;

  @override
  Widget build(BuildContext context) {
    return AnimatedPopup(
      child: AlertDialog(
        title: const Text('Reset Password'),
        content: const Text(
            'Are you sure you want to reset your password?\nA password reset link will be sent to your email address.'),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: Text(
              'Cancel',
              style:
                  TextStyle(color: context.theme.dividerColor.withOpacity(0.8)),
            ),
          ),
          TextButton(
            onPressed: () async => await pktbsResetPassword(context, email)
                .then((_) => context.pop()),
            child: Text('Confirm', style: TextStyle(color: context.theme.primaryColor)),
          ),
        ],
      ),
    );
  }
}
