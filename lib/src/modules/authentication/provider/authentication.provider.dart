import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef AuthNotifier = AutoDisposeNotifierProvider<AuthProvider, void>;

final authProvider = AuthNotifier(AuthProvider.new);

class AuthProvider extends AutoDisposeNotifier {
  final TextEditingController pwdConfirmCntrlr = TextEditingController();
  final TextEditingController usernameCntrlr = TextEditingController();
  final TextEditingController emailCntrlr = TextEditingController();
  final TextEditingController nameCntrlr = TextEditingController();
  final TextEditingController pwdCntrlr = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool pwdConfirmObscure = true;
  bool pwdObscure = true;
  dynamic image;

  bool isSignup = false;


  @override
  void build() {}

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

  void clear() {
    formKey = GlobalKey<FormState>();
    usernameCntrlr.clear();
    emailCntrlr.clear();
    pwdCntrlr.clear();
    pwdConfirmCntrlr.clear();
    nameCntrlr.clear();
    image = null;
    ref.notifyListeners();
  }
}
