import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:isar/isar.dart';

import '../../../../../db/hive/hive.dart';

part 'measurement.ext.dart';
part 'measurement.g.dart';

@HiveType(typeId: HiveTypes.measurement)
class Measurement extends HiveObject {
  Measurement();

  @HiveField(0)
  late final String name;
  @HiveField(1)
  late final String symbol;
  @HiveField(2)
  late final String unitOf;
  @HiveField(3)
  late final String system;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        _Json.symbol: symbol,
        _Json.unitOf: unitOf,
        _Json.system: system,
        _Json.name: name,
      };

  factory Measurement.fromRawJson(String source) =>
      Measurement.fromJson(json.decode(source));

  factory Measurement.fromJson(Map<String, dynamic> map) => Measurement()
    ..symbol = map[_Json.symbol]
    ..unitOf = map[_Json.unitOf]
    ..system = map[_Json.system]
    ..name = map[_Json.name];

  @override
  String toString() =>
      'Measurement{symbol: $symbol, unitOf: $unitOf, system: $system, name: $name}';

  @override
  bool operator ==(Object other) =>
      other is Measurement &&
      symbol == other.symbol &&
      unitOf == other.unitOf &&
      system == other.system &&
      name == other.name;

  @Ignore()
  @override
  int get hashCode =>
      symbol.hashCode ^ unitOf.hashCode ^ system.hashCode ^ name.hashCode;
}

class _Json {
  static const name = 'name';
  static const symbol = 'symbol';
  static const unitOf = 'unit_of';
  static const system = 'system';
}
