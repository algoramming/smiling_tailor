import 'package:flutter/material.dart';
import '../../model/user.type.enum.dart';

import '../../../../config/constants.dart';
import '../../../../utils/extensions/extensions.dart';
import '../../../../utils/transations/down.to.up.dart';
import '../../provider/authentication.provider.dart';
import 'reset.password.dart';

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
                        controller: notifier.nameCntrlr,
                        decoration: const InputDecoration(
                          labelText: 'Name',
                          hintText: 'Enter your name...',
                        ),
                        onFieldSubmitted: (_) async => notifier.submit(context),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
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
                        keyboardType: TextInputType.name,
                        validator: (v) {
                          if (notifier.isSignup && v!.isEmpty) {
                            return 'Username is required';
                          }
                          if (notifier.isSignup && !v!.isUsername) {
                            return 'Username must be at least 6 characters';
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
                keyboardType: TextInputType.emailAddress,
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
            DownToUpTransition(
              child: !notifier.isSignup
                  ? const SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: DropdownButtonFormField(
                        borderRadius: borderRadius15,
                        value: notifier.type,
                        decoration: const InputDecoration(
                          labelText: 'User Type',
                          hintText: 'From where you buy this inventory...',
                        ),
                        onChanged: (v) => notifier.changeType(v),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        items: UserType.values
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Row(
                                  children: [
                                    Container(
                                      height: 10.0,
                                      width: 10.0,
                                      margin:
                                          const EdgeInsets.only(right: 10.0),
                                      decoration: BoxDecoration(
                                        color: e.color,
                                        borderRadius: borderRadius30,
                                      ),
                                    ),
                                    Text(e.title),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                        validator: (v) {
                          if (v == null) {
                            return 'Vendor selection is required';
                          }
                          return null;
                        },
                      ),
                    ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: notifier.isSignup ? 10.0 : 5.0),
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
                keyboardType: TextInputType.text,
                validator: (v) {
                  if (v!.isEmpty) {
                    return 'Password is required';
                  }
                  if (notifier.isSignup && !v.isPassword) {
                    return 'Password must be at least 8 characters';
                  }
                  return null;
                },
              ),
            ),
            ForgetPasswordText(notifier),
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
                        keyboardType: TextInputType.text,
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
