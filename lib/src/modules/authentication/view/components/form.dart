import 'package:flutter/material.dart';

import '../../../../utils/transations/down.to.up.dart';
import '../../provider/authentication.provider.dart';

class AuthForm extends StatelessWidget {
  const AuthForm(this.notifier, {super.key});

  final AuthProvider notifier;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Form(
        key: notifier.formKey,
        child: Column(
          children: [
            DownToUpTransition(
              child: !notifier.isSignup
                  ? const SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: TextFormField(
                        controller: notifier.usernameCntrlr,
                        decoration: const InputDecoration(
                          labelText: 'Name',
                          hintText: 'Enter your name...',
                        ),
                      ),
                    ),
            ),
            DownToUpTransition(
              child: !notifier.isSignup
                  ? const SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: TextFormField(
                        controller: notifier.usernameCntrlr,
                        decoration: const InputDecoration(
                          labelText: 'Username',
                          hintText: 'Enter your username...',
                        ),
                      ),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: TextFormField(
                controller: notifier.emailCntrlr,
                decoration: InputDecoration(
                  labelText: notifier.isSignup ? 'Email' : 'Email/Username',
                  hintText: notifier.isSignup
                      ? 'Enter your email...'
                      : 'Enter your email or username...',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: TextFormField(
                controller: notifier.pwdCntrlr,
                obscureText: notifier.pwdObscure,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password...',
                  suffixIcon: IconButton(
                    icon: Icon(notifier.pwdObscure
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: notifier.togglePwdObscure,
                  ),
                ),
              ),
            ),
            DownToUpTransition(
              child: !notifier.isSignup
                  ? const SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: TextFormField(
                        controller: notifier.pwdConfirmCntrlr,
                        obscureText: notifier.pwdConfirmObscure,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          hintText: 'Enter your password again...',
                          suffixIcon: IconButton(
                            icon: Icon(notifier.pwdConfirmObscure
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: notifier.toggleConfirmPwdObscure,
                          ),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
