import 'package:flutter/material.dart';

import '../../config/get.platform.dart';
import 'components/android.ios.image.dart';
import 'components/linux.windows.macos.image.dart';
import 'components/web.image.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget(this.image, {super.key});

  final dynamic image;

  @override
  Widget build(BuildContext context) {
    return pt == PT.isWeb
        ? WebImage(image.bytes!)
        : pt == PT.isAndroid || pt == PT.isIOS
            ? AndroidIOSImage(image)
            : LinuxWindowsMacOsImage(image);
  }
}
