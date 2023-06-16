import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:isar/isar.dart';

import '../../../../../db/hive/hive.dart';

part 'currency.model.crud.ext.dart';
part 'currency.model.ext.dart';
part 'currency.model.g.dart';

@HiveType(typeId: HiveTypes.currencyProfile)
class CurrencyProfile {
  CurrencyProfile();

  @HiveField(0)
  late final String name;
  @HiveField(1)
  late final String symbol;
  @HiveField(2)
  late final String shortForm;

  factory CurrencyProfile.fromRawJson(String str) =>
      CurrencyProfile.fromJson(json.decode(str));

  factory CurrencyProfile.fromJson(Map<String, dynamic> json) =>
      CurrencyProfile()
        ..name = json[_JSON.name] as String
        ..symbol = json[_JSON.symbol] as String
        ..shortForm = json[_JSON.shortForm] as String;

  @override
  bool operator ==(Object other) => other is CurrencyProfile && name == other.name && symbol == other.symbol && shortForm == other.shortForm;

  @Ignore()
  @override
  int get hashCode => name.hashCode ^ symbol.hashCode ^ shortForm.hashCode;
}

class _JSON {
  static const String name = 'name';
  static const String symbol = 'symbol';
  static const String shortForm = 'short_form';
}
