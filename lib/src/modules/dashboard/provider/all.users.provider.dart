import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pocketbase/auth.store/helpers.dart';
import '../../authentication/model/user.dart';
import '../../transaction/model/transaction.dart';
import '../../transaction/provider/all.trxs.provider.dart';

typedef AllUsersNotifier
    = AsyncNotifierProvider<AllUsersProvider, List<PktbsUser>>;

final allUsersProvider = AllUsersNotifier(AllUsersProvider.new);

class AllUsersProvider extends AsyncNotifier<List<PktbsUser>> {
  final searchCntrlr = TextEditingController();
  late List<PktbsUser> _users;
  @override
  FutureOr<List<PktbsUser>> build() async {
    _users = [];
    _listener();
    _stream();
    _users = await pb
        .collection(users)
        .getFullList()
        .then((r) => r.map((e) => PktbsUser.fromJson(e.toJson())).toList());
    return _users;
  }

  _listener() => searchCntrlr.addListener(() => ref.notifyListeners());

  _stream() {
    pb.collection(users).subscribe('*', (s) {
      _users.add(PktbsUser.fromJson(s.record!.toJson()));
      ref.notifyListeners();
    });
  }

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

/////////////////////////////////////////////////////////////////////////////////////

typedef UserTrxsNotifier = AutoDisposeAsyncNotifierProviderFamily<
    UserTrxsProvider, List<PktbsTrx>, PktbsUser>;

final userTrxsProvider = UserTrxsNotifier(UserTrxsProvider.new);

class UserTrxsProvider
    extends AutoDisposeFamilyAsyncNotifier<List<PktbsTrx>, PktbsUser> {
  final searchCntrlr = TextEditingController();
  late List<PktbsTrx> _trxs;
  @override
  FutureOr<List<PktbsTrx>> build(PktbsUser arg) async {
    _trxs = [];
    _listener();
    ref.watch(allTrxsProvider
        // .select((v) => v.value?.any((e) => e.fromId == arg.id || e.toId == arg.id)) // TODO: Issue
        );
    _trxs = (await ref.watch(allTrxsProvider.future))
        .where((trx) =>
            trx.isActive && (trx.fromId == arg.id || trx.toId == arg.id))
        .toList();
    return _trxs;
  }

  _listener() => searchCntrlr.addListener(() => ref.notifyListeners());

  List<PktbsTrx> get rawTrxsList => _trxs;

  List<PktbsTrx> get trxList {
    _trxs.sort((a, b) => b.created.toLocal().compareTo(a.created.toLocal()));
    final vs = _trxs;
    return vs
        .where((e) =>
            e.id.toLowerCase().contains(searchCntrlr.text.toLowerCase()) ||
            e.fromId.toLowerCase().contains(searchCntrlr.text.toLowerCase()) ||
            e.toId.toLowerCase().contains(searchCntrlr.text.toLowerCase()) ||
            e.creator.id
                .toLowerCase()
                .contains(searchCntrlr.text.toLowerCase()) ||
            (e.updator?.id
                    .toLowerCase()
                    .contains(searchCntrlr.text.toLowerCase()) ??
                false) ||
            (e.description
                    ?.toLowerCase()
                    .contains(searchCntrlr.text.toLowerCase()) ??
                false))
        .toList();
  }
}
