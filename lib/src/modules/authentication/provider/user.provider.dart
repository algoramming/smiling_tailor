import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/user.dart';
import '../../../pocketbase/auth.store/helpers.dart';

typedef UserNotifier = AsyncNotifierProvider<UserProvider, List<PktbsUser>>;

final userProvider = UserNotifier(UserProvider.new);

class UserProvider extends AsyncNotifier<List<PktbsUser>> {
  late List<PktbsUser> userList;

  @override
  FutureOr<List<PktbsUser>> build() async {
    final id = PktbsUser.fromJson(pb.authStore.model!.toJson()).id;
    _stream(id);
    await pb
        .collection(users)
        .getOne(id)
        .then((r) => userList = [PktbsUser.fromJson(r.toJson())]);
    return userList;
  }

  _stream(String id) {
    pb.collection(users).subscribe(id, (s) {
      userList.add(PktbsUser.fromJson(s.record!.toJson()));
      ref.notifyListeners();
    });
  }
}
