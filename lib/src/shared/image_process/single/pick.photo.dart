import 'package:flutter/material.dart';

import '../../../config/get.platform.dart';
import 'file.picker.dart';
import 'modal.bottom.sheet.menu.dart';

Future<Object?> pickPhoto(BuildContext context, {bool isCircle = false}) async {
  // if (kIsWeb) {
  //   return await filePickFromDevice();
  // } else {
  if (pt == PT.isAndroid || pt == PT.isIOS) {
    return await modalBottomSheetMenu(context, isCircle: isCircle);
  }
  return await filePickFromDevice();
  // }
}
