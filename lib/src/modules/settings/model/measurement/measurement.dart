import 'dart:convert';

import 'package:isar/isar.dart';

import '../../../../db/isar.dart';

part 'measurement.ext.dart';
part 'measurement.g.dart';

@Collection()
class Measurement {
  Measurement();

  Id? id;

  @Index(type: IndexType.hash)
  late final String symbol;

  late final String unitOf;
  late final String system;
  late final String name;

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
      'Measurement{id: $id, symbol: $symbol, unitOf: $unitOf, system: $system, name: $name}';

  @override
  bool operator ==(Object other) => other is Measurement && id == other.id;

  @Ignore()
  @override
  int get hashCode => id.hashCode;
}

class _Json {
  static const symbol = 'symbol';
  static const unitOf = 'unit_of';
  static const system = 'system';
  static const name = 'name';
}
