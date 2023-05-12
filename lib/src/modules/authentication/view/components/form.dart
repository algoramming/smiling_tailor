import 'package:flutter/material.dart';
import '../../../../utils/extensions/extensions.dart';

import '../../../../utils/transations/down.to.up.dart';
import '../../provider/authentication.provider.dart';

class AuthForm extends StatelessWidget {
  const AuthForm(this.notifier, {super.key});

  final AuthProvider notifier;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
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
                        style: const TextStyle(),
                        controller: notifier.nameCntrlr,
                        decoration: const InputDecoration(
                          labelText: 'Name',
                          hintText: 'Enter your name...',
                        ),
                        onFieldSubmitted: (_) async => notifier.submit(context),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textInputAction: TextInputAction.next,
                        validator: (v) {
                          if (notifier.isSignup && v!.isEmpty) {
                            return 'Name is required';
                          }
                          return null;
                        },
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
                        onFieldSubmitted: (_) async => notifier.submit(context),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textInputAction: TextInputAction.next,
                        validator: (v) {
                          if (notifier.isSignup && v!.isEmpty) {
                            return 'Username is required';
                          }
                          return null;
                        },
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
                onFieldSubmitted: (_) async => notifier.submit(context),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textInputAction: TextInputAction.next,
                validator: (v) {
                  if (v!.isEmpty) {
                    return 'Email is required';
                  }
                  if (notifier.isSignup && !v.isEmail) {
                    return 'Invalid email';
                  }
                  return null;
                },
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
                onFieldSubmitted: (_) async => notifier.submit(context),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textInputAction: notifier.isSignup
                    ? TextInputAction.next
                    : TextInputAction.done,
                validator: (v) {
                  if (v!.isEmpty) {
                    return 'Password is required';
                  }
                  if (notifier.isSignup && v.length < 8) {
                    return 'Password must be at least 8 characters';
                  }
                  return null;
                },
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
                        onFieldSubmitted: (_) async => notifier.submit(context),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textInputAction: TextInputAction.done,
                        validator: (v) {
                          if (notifier.isSignup &&
                              v != notifier.pwdCntrlr.text) {
                            return 'Password does not match';
                          }
                          return null;
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
