import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pocketbase/auth.store/helpers.dart';
import '../../../utils/logger/logger_helper.dart';
import '../model/user.dart';

typedef UserNotifier
    = AutoDisposeAsyncNotifierProvider<UserProvider, List<PktbsUser>>;

final userProvider = UserNotifier(UserProvider.new);

final pbStream = StreamProvider((_) => pb.authStore.onChange);

class UserProvider extends AutoDisposeAsyncNotifier<List<PktbsUser>> {
  late List<PktbsUser> userList;

  @override
  FutureOr<List<PktbsUser>> build() async {
    final id = PktbsUser.fromJson(pb.authStore.model?.toJson()).id;
    try {
      _stream(id);
      await pb
          .collection(users)
          .getOne(id)
          .then((r) => userList = [PktbsUser.fromJson(r.toJson())]);
    } catch (e) {
      log.e('User Provider Error: $e');
      userList = [];
    }
    return userList;
  }

  _stream(String id) {
    pb.collection(users).subscribe(id, (s) {
      userList.add(PktbsUser.fromJson(s.record!.toJson()));
      ref.notifyListeners();
    });
  }
}
