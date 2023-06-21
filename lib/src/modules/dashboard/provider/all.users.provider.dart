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
    // _stream();
    // _trxs = await pb
    //     .collection(transactions)
    //     .getFullList(
    //       filter: 'from_id = "${arg.id}" || to_id = "${arg.id}"',
    //       expand: pktbsTrxExpand,
    //     )
    //     .then((v) {
    //   log.i('User Trxs: $v');
    //   return v.map((e) => PktbsTrx.fromJson(e.toJson())).toList();
    // });
    ref.watch(allTrxsProvider);
    _trxs = (await ref.watch(allTrxsProvider.future))
        .where((trx) => trx.fromId == arg.id || trx.toId == arg.id)
        .toList();
    return _trxs;
  }

  _listener() => searchCntrlr.addListener(() => ref.notifyListeners());

  // _stream() {
  //   // Implement Stream needs pocketbase update to add filter and expand options then the autodispose had to remove
  //   pb.collection(transactions).subscribe('*', (s) async {
  //     log.i('Stream $s');
  //     if (s.record?.getStringValue('from_id') != arg.id &&
  //         s.record?.getStringValue('to_id') != arg.id) return;
  //     await pb
  //         .collection(transactions)
  //         .getOne(s.record!.toJson()['id'], expand: pktbsTrxExpand)
  //         .then((trx) {
  //       log.i('Stream After Get Trx: $trx');
  //       if (s.action == 'create') {
  //         _trxs.add(PktbsTrx.fromJson(trx.toJson()));
  //       } else if (s.action == 'update') {
  //         _trxs.removeWhere((e) => e.id == trx.id);
  //         _trxs.add(PktbsTrx.fromJson(trx.toJson()));
  //       } else if (s.action == 'delete') {
  //         _trxs.removeWhere((e) => e.id == trx.id);
  //       }
  //       ref.notifyListeners();
  //     });
  //   });
  // }

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
