import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../../db/hive.dart';
import '../../../../localization/loalization.dart';

part 'locale.model.ext.dart';
part 'locale.model.g.dart';


@HiveType(typeId: HiveTypes.localeProfile)
enum LocaleProfile {
  @HiveField(0)
  arabic,
  @HiveField(1)
  bengali,
  @HiveField(2)
  english,
  @HiveField(3)
  hindi,
  @HiveField(4)
  urdu,
}
