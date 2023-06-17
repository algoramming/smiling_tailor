import 'dart:io';

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:pocketbase/pocketbase.dart';

import '../../../config/get.platform.dart';
import '../../../pocketbase/auth.store/helpers.dart';
import '../../../pocketbase/error.handle/error.handle.func.dart';
import '../../../shared/show_toast/awsome.snackbar/awesome.snackbar.dart';
import '../../../shared/show_toast/awsome.snackbar/show.awesome.snackbar.dart';
import '../../../utils/extensions/extensions.dart';
import '../../../utils/logger/logger_helper.dart';
import '../../profile/provider/profile.provider.dart';
import '../provider/authentication.provider.dart';

Future<void> pktbsSignup(BuildContext context, AuthProvider notifier,
    [bool autoSignin = true]) async {
  EasyLoading.show(status: 'Creating account...');
  try {
    await pb.collection(users).create(
      body: {
        'emailVisibility': true,
        'name': notifier.nameCntrlr.text,
        'email': notifier.emailCntrlr.text,
        'password': notifier.pwdCntrlr.text,
        'username': notifier.usernameCntrlr.text,
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
  } on SocketException catch (e) {
    EasyLoading.showError('No Internet Connection. $e');
    return;
  } on ClientException catch (e) {
    log.e('User Creation: $e');
    showAwesomeSnackbar(
        context, 'Failed!', getErrorMessage(e), MessageType.failure);
    return;
  }
}

Future<void> pktbsSignin(BuildContext context, AuthProvider notifier) async {
  EasyLoading.show(status: 'Matching Credentials...');
  final beam = Beamer.of(context);
  try {
    await pb
        .collection(users)
        .authWithPassword(notifier.emailCntrlr.text, notifier.pwdCntrlr.text)
        .then((res) {
      log.i('User signin: $res');
      notifier.clear();
    });
    EasyLoading.dismiss();
    beam.update();
    return;
  } on SocketException catch (e) {
    EasyLoading.showError('No Internet Connection. $e');
    return;
  } on ClientException catch (e) {
    log.e('User signin: $e');
    showAwesomeSnackbar(
        context, 'Failed!', getErrorMessage(e), MessageType.failure);
    return;
  }
}

Future<void> pktbsSendVerificationEmail(
  BuildContext context,
  String email,
) async {
  try {
    EasyLoading.show(status: 'Sending email...');
    await pb
        .collection(users)
        .requestVerification(email)
        .onError((error, stackTrace) => showAwesomeSnackbar(context, 'Failed!',
            getErrorMessage(error as ClientException), MessageType.failure))
        .then((_) => showAwesomeSnackbar(context, 'Success!',
            'Verification email sent.', MessageType.success));
    return;
  } on SocketException catch (e) {
    EasyLoading.showError('No Internet Connection. $e');
    return;
  }
}

Future<void> pktbsResetPassword(BuildContext context, String email) async {
  EasyLoading.show(status: 'Sending email...');
  try {
    await pb
        .collection(users)
        .requestPasswordReset(email)
        .onError((error, stackTrace) => showAwesomeSnackbar(context, 'Failed!',
            getErrorMessage(error as ClientException), MessageType.failure))
        .then((_) => showAwesomeSnackbar(context, 'Success!',
            'Password reset email sent.', MessageType.success));
    return;
  } on SocketException catch (e) {
    EasyLoading.showError('No Internet Connection. $e');
    return;
  }
}

Future<void> pktbsUpdate(
  BuildContext context,
  ProfileProvider notifier,
  bool isImageUpdated,
) async {
  try {
    EasyLoading.show(status: 'Updating...');
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
  } on SocketException catch (e) {
    EasyLoading.showError('No Internet Connection. $e');
    return;
  } on ClientException catch (e) {
    log.e('User Update: $e');
    showAwesomeSnackbar(
        context, 'Failed!', getErrorMessage(e), MessageType.failure);
    return;
  }
}

Future<void> pktbsSignout(BuildContext context) async {
  EasyLoading.show(status: 'Signing out...');
  try {
    await pb.realtime.unsubscribe().then((_) async {
      pb.authStore.clear();
      EasyLoading.dismiss();
      log.i('User signout and unsubscribed from all registered subscriptions.');
      // await context.pushNamedRemoveUntil(AppRouter.name);
      context.beamUpdate();
      return;
    });
  } on SocketException catch (e) {
    EasyLoading.showError('No Internet Connection. $e');
    return;
  } on ClientException catch (e) {
    log.e('User signout: $e');
    showAwesomeSnackbar(
        context, 'Failed!', getErrorMessage(e), MessageType.failure);
    return;
  }
}
