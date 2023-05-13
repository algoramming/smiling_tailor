import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../authentication/model/user.dart';
import '../../authentication/provider/user.provider.dart';

import '../../authentication/api/authentication.api.dart';

typedef ProfileNotifier = NotifierProvider<ProfileProvider, PktbsUser?>;

final profileProvider = ProfileNotifier(ProfileProvider.new);

class ProfileProvider extends Notifier<PktbsUser?> {
  late TextEditingController usernameCntrlr;
  late TextEditingController emailCntrlr;
  late TextEditingController nameCntrlr;
  late GlobalKey<FormState> formKey;
  bool isEditable = false;
  dynamic image;

  @override
  PktbsUser? build() {
    final user =  ref.watch(userProvider).value?.last;
    usernameCntrlr = TextEditingController(text: user?.username);
    emailCntrlr = TextEditingController(text: user?.email);
    nameCntrlr = TextEditingController(text: user?.name);
    formKey = GlobalKey<FormState>();
    return user;
  }

  PktbsUser? get user => state;

  void toggleEditable() {
    isEditable = !isEditable;
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

  Future<void> submit(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    await pktbsUpdate(context, this, image != null);
  }

  void clear() {
    usernameCntrlr.text = user?.username ?? '';
    emailCntrlr.text = user?.email ?? '';
    nameCntrlr.text = user?.name ?? '';
    image = null;
    isEditable = false;
    ref.notifyListeners();
  }
}
