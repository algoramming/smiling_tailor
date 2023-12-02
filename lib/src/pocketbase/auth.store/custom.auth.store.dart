// import 'dart:convert';

// import 'package:pocketbase/pocketbase.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// const key = 'pb_auth';

// class CustomAuthStore extends AuthStore {
//   final SharedPreferences prefs;

//   CustomAuthStore(this.prefs) {
//     final String? raw = prefs.getString(key);

//     if (raw != null && raw.isNotEmpty) {
//       final decoded = jsonDecode(raw);
//       final token = (decoded as Map<String, dynamic>)['token'] as String? ?? '';
//       final model = RecordModel.fromJson(decoded['model'] as Map<String, dynamic>? ?? {});

//       save(token, model);
//     }
//   }

//   @override
//   void save(
//     String newToken,
//     dynamic /* RecordModel|AdminModel|null */ newModel,
//   ) {
//     super.save(newToken, newModel);

//     final encoded = jsonEncode(<String, dynamic>{'token': newToken, 'model': newModel});
//     prefs.setString(key, encoded);
//   }

//   @override
//   void clear() {
//     super.clear();
//     prefs.remove(key);
//   }
// }
