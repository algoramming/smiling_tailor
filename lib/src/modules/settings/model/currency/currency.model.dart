import 'dart:convert';
import 'dart:math';

import 'package:hive/hive.dart';

import '../../../../db/hive.dart';

part 'currency.model.crud.ext.dart';
part 'currency.model.ext.dart';
part 'currency.model.g.dart';

@HiveType(typeId: HiveTypes.currencyProfile)
class CurrencyProfile {
  CurrencyProfile();

  @HiveField(0)
  final id = '${DateTime.now().microsecondsSinceEpoch + Random().nextInt(999999)}';
  @HiveField(1)
  late final String name;
  @HiveField(2)
  late final String symbol;
  @HiveField(3)
  late final String shortForm;

  factory CurrencyProfile.fromRawJson(String str) =>
      CurrencyProfile.fromJson(json.decode(str));

  factory CurrencyProfile.fromJson(Map<String, dynamic> json) =>
      CurrencyProfile()
        ..name = json[_JSON.name] as String
        ..symbol = json[_JSON.symbol] as String
        ..shortForm = json[_JSON.shortForm] as String;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        _JSON.id: id,
        _JSON.name: name,
        _JSON.symbol: symbol,
        _JSON.shortForm: shortForm,
      };

  @override
  bool operator ==(Object other) => other is CurrencyProfile && id == other.id;

  @override
  int get hashCode => name.hashCode ^ symbol.hashCode ^ shortForm.hashCode;
}

class _JSON {
  static const String id = 'id';
  static const String name = 'name';
  static const String symbol = 'symbol';
  static const String shortForm = 'short_form';
}
