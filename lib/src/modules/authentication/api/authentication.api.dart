import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pocketbase/pocketbase.dart';

import '../../../config/get.platform.dart';
import '../../../pocketbase/auth.store/helpers.dart';
import '../../../pocketbase/error.handle/error.handle.func.dart';
import '../../../shared/show_toast/awesome_snackbar.dart';
import '../../../shared/show_toast/show_toast.dart';
import '../../../utils/extensions/extensions.dart';
import '../../../utils/logger/logger_helper.dart';
import '../../home/view/home.view.dart';
import '../../profile/provider/profile.provider.dart';
import '../provider/authentication.provider.dart';
import '../view/authentication.dart';

Future<void> pktbsSignup(BuildContext context, AuthProvider notifier,
    [bool autoSignin = true]) async {
  try {
    await pb.collection(users).create(
      body: {
        'name': notifier.nameCntrlr.text,
        'email': notifier.emailCntrlr.text,
        'password': notifier.pwdCntrlr.text,
        'username': notifier.usernameCntrlr.text,
        'emailVisibility': true,
        'passwordConfirm': notifier.pwdConfirmCntrlr.text,
      },
      files: notifier.image == null
          ? []
          : [
              pt == PT.isWeb
                  ? http.MultipartFile.fromBytes(
                      'avatar',
                      notifier.image!.bytes!,
                      filename: '${notifier.usernameCntrlr.text}.png',
                    )
                  : await http.MultipartFile.fromPath(
                      'avatar',
                      notifier.image!.path,
                      filename: '${notifier.usernameCntrlr.text}.png',
                    )
            ],
    ).then((_) async {
      if (autoSignin) {
        await pktbsSignin(context, notifier);
      } else {
        notifier.clear();
        showAwesomeSnackbar(context, 'Success!', 'User created successfully.',
            MessageType.success);
      }
    });
    return;
  } on ClientException catch (e) {
    log.e('User Creation: $e');
    showAwesomeSnackbar(
        context, 'Failed!', getErrorMessage(e), MessageType.failure);
    return;
  }
}

Future<void> pktbsSignin(BuildContext context, AuthProvider notifier) async {
  final nav = Navigator.of(context);
  try {
    await pb
        .collection(users)
        .authWithPassword(notifier.emailCntrlr.text, notifier.pwdCntrlr.text)
        .then((res) {
      log.i('User signin: $res');
      notifier.clear();
    });
    await nav.pushNamedRemoveUntil(HomeView.name);
    return;
  } on ClientException catch (e) {
    log.e('User signin: $e');
    showAwesomeSnackbar(
        context, 'Failed!', getErrorMessage(e), MessageType.failure);
    return;
  }
}

Future<void> pktbsSignout(BuildContext context) async {
  try {
    pb.authStore.clear();
    await context.pushNamedRemoveUntil(AuthenticationView.name);
    return;
  } on ClientException catch (e) {
    log.e('User signout: $e');
    showAwesomeSnackbar(
        context, 'Failed!', getErrorMessage(e), MessageType.failure);
    return;
  }
}

Future<void> pktbsSendVerificationEmail(
    BuildContext context, String email) async {
  await pb
      .collection(users)
      .requestVerification(email)
      .onError((error, stackTrace) => showAwesomeSnackbar(context, 'Failed!',
          getErrorMessage(error as ClientException), MessageType.failure))
      .then((_) => showAwesomeSnackbar(context, 'Success!',
          'Verification email sent.', MessageType.success));
  return;
}

Future<void> pktbsResetPassword(BuildContext context, String email) async {
  await pb
      .collection(users)
      .requestPasswordReset(email)
      .onError((error, stackTrace) => showAwesomeSnackbar(context, 'Failed!',
          getErrorMessage(error as ClientException), MessageType.failure))
      .then((_) => showAwesomeSnackbar(context, 'Success!',
          'Password reset email sent.', MessageType.success));
  return;
}

Future<void> pktbsUpdate(
    BuildContext context, ProfileProvider notifier, bool isImageUpdated) async {
  try {
    await pb
        .collection(users)
        .update(
          notifier.user!.id,
          body: {
            'name': notifier.nameCntrlr.text,
            'email': notifier.emailCntrlr.text,
            'username': notifier.usernameCntrlr.text,
          },
          files: isImageUpdated
              ? [
                  pt == PT.isWeb
                      ? http.MultipartFile.fromBytes(
                          'avatar',
                          notifier.image!.bytes!,
                          filename: '${notifier.usernameCntrlr.text}.png',
                        )
                      : await http.MultipartFile.fromPath(
                          'avatar',
                          notifier.image!.path,
                          filename: '${notifier.usernameCntrlr.text}.png',
                        )
                ]
              : [],
        )
        .then((_) async {
      notifier.clear();
      showAwesomeSnackbar(context, 'Success!', 'User updated successfully.',
          MessageType.success);
    });
    return;
  } on ClientException catch (e) {
    log.e('User Update: $e');
    showAwesomeSnackbar(
        context, 'Failed!', getErrorMessage(e), MessageType.failure);
    return;
  }
}
