import 'package:flutter/material.dart';

import '../utils/extensions/extensions.dart';
import 'get.platform.dart';

bool isNeedZoomAdjust(BuildContext context) =>
    pt.isWeb && context.mq.textScaler !=  const TextScaler.linear(1.0);
