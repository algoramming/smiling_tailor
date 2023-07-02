import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smiling_tailor/src/modules/dashboard/provider/all.users.provider.dart';
import 'package:smiling_tailor/src/pocketbase/auth.store/helpers.dart';

import '../../authentication/model/user.dart';

typedef AllUsersNotifier
    = AsyncNotifierProvider<AllManagersProvider, List<PktbsUser>>;

final allManagersProvider = AllUsersNotifier(AllManagersProvider.new);

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
