import 'package:pocketbase/pocketbase.dart';

String getErrorMessage(ClientException e) {
  final dataList = e.response['data']?.values.toList();
  final messageList =
      dataList?.map((e) => e['message'].toString()).toList() ?? [];
  return [e.response['message'] ?? '', ...messageList, e.originalError ?? '']
      .join('\n');
}
