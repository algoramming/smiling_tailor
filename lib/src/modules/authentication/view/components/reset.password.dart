import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/constants.dart';
import '../../../../shared/animations_widget/animated_popup.dart';
import '../../../../utils/extensions/extensions.dart';
import '../../../../utils/transations/down.to.up.dart';
import '../../api/authentication.api.dart';
import '../../provider/authentication.provider.dart';

class ForgetPasswordText extends ConsumerWidget {
  const ForgetPasswordText(this.notifier, {super.key});

  final AuthProvider notifier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DownToUpTransition(
      child: notifier.isSignup
          ? const SizedBox.shrink()
          : Padding(
              padding: const EdgeInsets.only(bottom: 7.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () async => await showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const ForgetPasswordPopup(),
                  ),
                  child: Text(
                    'Forget Password?',
                    style: context.theme.textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.theme.primaryColor,
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}

class ForgetPasswordPopup extends StatefulWidget {
  const ForgetPasswordPopup({super.key});

  @override
  State<ForgetPasswordPopup> createState() => _ForgetPasswordPopupState();
}

class _ForgetPasswordPopupState extends State<ForgetPasswordPopup> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailCntrlr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AnimatedPopup(
      child: AlertDialog(
        title: const Text('Forget Password'),
        content: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: mainMin,
              children: [
                const Text(
                    'A reset password link will be sent to your email address.'),
                const SizedBox(height: 10.0),
                TextFormField(
                  controller: emailCntrlr,
                  decoration: const InputDecoration(
                    hintText: 'Enter your email',
                    labelText: 'Email',
                  ),
                  onFieldSubmitted: (_) async => submit(),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textInputAction: TextInputAction.next,
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'Email is required';
                    }
                    if (!v.isEmail) {
                      return 'Invalid email';
                    }
                    return null;
                  },
                )
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async => await submit(),
            child: Text('Send Email',
                style: TextStyle(color: context.theme.primaryColor)),
          ),
        ],
      ),
    );
  }

  Future<void> submit() async {
    if (formKey.currentState!.validate()) {
      await pktbsResetPassword(context, emailCntrlr.text)
          .then((_) => context.pop());
    }
  }
}
