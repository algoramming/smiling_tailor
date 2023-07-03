import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../main.dart';
import '../api/authentication.api.dart';
import '../model/user.type.enum.dart';

typedef AuthNotifier
    = AutoDisposeNotifierProviderFamily<AuthProvider, void, bool>;

final authProvider = AuthNotifier(AuthProvider.new);

class AuthProvider extends AutoDisposeFamilyNotifier<void, bool> {
  final TextEditingController pwdConfirmCntrlr = TextEditingController();
  final TextEditingController usernameCntrlr = TextEditingController();
  final TextEditingController emailCntrlr = TextEditingController();
  final TextEditingController nameCntrlr = TextEditingController();
  final TextEditingController pwdCntrlr = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  UserType type = UserType.operate;
  bool pwdConfirmObscure = true;
  bool pwdObscure = true;
  dynamic image;

  late bool isSignup;

  @override
  void build(bool arg) {
    isSignup = arg;
    if (!isProduction && !isSignup) {
      emailCntrlr.text = 'test@algoramming.com';
      pwdCntrlr.text = '12345678';
    }
    if (isSignup) {
      pwdCntrlr.text = '12345678';
      pwdConfirmCntrlr.text = '12345678';
    }
  }

  void toggleIsSignup() {
    isSignup = !isSignup;
    ref.notifyListeners();
  }

  void togglePwdObscure() {
    pwdObscure = !pwdObscure;
    ref.notifyListeners();
  }

  void toggleConfirmPwdObscure() {
    pwdConfirmObscure = !pwdConfirmObscure;
    ref.notifyListeners();
  }

  void setImage(var img) {
    image = img;
    ref.notifyListeners();
  }

  void removeImage() {
    image = null;
    ref.notifyListeners();
  }

  void changeType(UserType? type) {
    if (type == null) return;
    this.type = type;
    ref.notifyListeners();
  }

  void clear() {
    formKey = GlobalKey<FormState>();
    pwdConfirmCntrlr.clear();
    type = UserType.manager;
    usernameCntrlr.clear();
    emailCntrlr.clear();
    nameCntrlr.clear();
    pwdCntrlr.clear();
    image = null;
    ref.notifyListeners();
  }

  Future<void> submit(BuildContext context) async =>
      isSignup ? await signup(context) : await signin(context);

  Future<void> signup(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    await pktbsSignup(context, this, false);
  }

  Future<void> signin(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    await pktbsSignin(context, this);
  }
}
