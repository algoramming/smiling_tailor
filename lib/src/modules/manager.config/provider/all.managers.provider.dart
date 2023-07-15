import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketbase/pocketbase.dart';

import '../../../pocketbase/auth.store/helpers.dart';
import '../../../pocketbase/error.handle/error.handle.func.dart';
import '../../../shared/show_toast/awsome.snackbar/awesome.snackbar.dart';
import '../../../shared/show_toast/awsome.snackbar/show.awesome.snackbar.dart';
import '../../../utils/logger/logger_helper.dart';
import '../../authentication/model/user.dart';
import '../../authentication/model/user.type.enum.dart';
import '../../dashboard/provider/all.users.provider.dart';

typedef AllManagersNotifier
    = AsyncNotifierProvider<AllManagersProvider, List<PktbsUser>>;

final allManagersProvider = AllManagersNotifier(AllManagersProvider.new);

class AllManagersProvider extends AsyncNotifier<List<PktbsUser>> {
  final searchCntrlr = TextEditingController();
  late List<PktbsUser> _users;
  @override
  FutureOr<List<PktbsUser>> build() async {
    _users = [];
    _listener();
    _users = await ref.watch(allUsersProvider.future);
    _users.any((e) => e.id == pb.authStore.model.id)
        ? _users.removeWhere((e) => e.id == pb.authStore.model.id)
        : null;
    return _users;
  }

  _listener() => searchCntrlr.addListener(() => ref.notifyListeners());

  List<PktbsUser> get rawUserList => _users;

  List<PktbsUser> get usersList {
    _users.sort((a, b) => b.created.toLocal().compareTo(a.created.toLocal()));
    final us = _users;
    return us
        .where((e) =>
            e.id.toLowerCase().contains(searchCntrlr.text.toLowerCase()) ||
            e.name.toLowerCase().contains(searchCntrlr.text.toLowerCase()) ||
            e.email.toLowerCase().contains(searchCntrlr.text.toLowerCase()) ||
            e.username.toLowerCase().contains(searchCntrlr.text.toLowerCase()))
        .toList();
  }
}

typedef ManagerNotifier
    = AutoDisposeNotifierProviderFamily<ManagerProvider, void, PktbsUser>;

final managerProvider = ManagerNotifier(ManagerProvider.new);

class ManagerProvider extends AutoDisposeFamilyNotifier<void, PktbsUser> {
  late int _userType;
  bool initiallyOpen = false;
  @override
  void build(PktbsUser arg) {
    _userType = arg.type.index;
  }

  int get userType => _userType;

  void changeUserType(int i) {
    _userType = i;
    ref.notifyListeners();
  }

  bool get showUpdateButton => _userType != arg.type.index;

  Future<void> updateRole(BuildContext context) async {
    try {
      EasyLoading.show(status: 'Updating...');
      await pb.collection(users).update(
        arg.id,
        body: {'type': UserType.values[_userType].title},
      ).then((_) async {
        ref.invalidate(allManagersProvider);
        showAwesomeSnackbar(context, 'Success!',
            'User Role updated successfully.', MessageType.success);
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
}
