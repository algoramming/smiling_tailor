import 'package:flutter/material.dart';

import '../../../../utils/extensions/extensions.dart';
import '../../provider/profile.provider.dart';

class ProfileForm extends StatelessWidget {
  const ProfileForm(this.notifier, {super.key});

  final ProfileProvider notifier;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Form(
        key: notifier.formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: TextFormField(
                enabled: notifier.isEditable,
                controller: notifier.nameCntrlr,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  hintText: 'Enter your name...',
                ),
                onFieldSubmitted: (_) async => notifier.submit(context),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textInputAction: TextInputAction.next,
                validator: (v) {
                  if (v!.isEmpty) {
                    return 'Name is required';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: TextFormField(
                enabled: false,
                controller: notifier.usernameCntrlr,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  hintText: 'Enter your username...',
                ),
                onFieldSubmitted: (_) async => notifier.submit(context),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textInputAction: TextInputAction.next,
                validator: (v) {
                  if (v!.isEmpty) {
                    return 'Username is required';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: TextFormField(
                enabled: false,
                controller: notifier.emailCntrlr,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email...',
                ),
                onFieldSubmitted: (_) async => notifier.submit(context),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
