import 'dart:convert';
import 'dart:math';

import 'package:hive/hive.dart';

import '../../../../db/hive.dart';
import '../../../../db/db.dart';

part 'measurement.ext.dart';
part 'measurement.g.dart';

@HiveType(typeId: HiveTypes.measurement)
class Measurement extends HiveObject {
  Measurement();

  @HiveField(0)
  final id ='${DateTime.now().microsecondsSinceEpoch + Random().nextInt(999999)}';
  @HiveField(1)
  late final String name;
  @HiveField(2)
  late final String symbol;
  @HiveField(3)
  late final String unitOf;
  @HiveField(4)
  late final String system;

  factory Measurement.fromRawJson(String source) =>
      Measurement.fromJson(json.decode(source));

  factory Measurement.fromJson(Map<String, dynamic> map) => Measurement()
    ..name = map[_Json.name]
    ..symbol = map[_Json.symbol]
    ..unitOf = map[_Json.unitOf]
    ..system = map[_Json.system];
  
  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        _Json.id: id,
        _Json.name: name,
        _Json.symbol: symbol,
        _Json.unitOf: unitOf,
        _Json.system: system,
      };

  @override
  String toString() =>
      'Measurement{id: $id symbol: $symbol, unitOf: $unitOf, system: $system, name: $name}';

  @override
  bool operator ==(Object other) => other is Measurement && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class _Json {
  static const id = 'id';
  static const name = 'name';
  static const symbol = 'symbol';
  static const system = 'system';
  static const unitOf = 'unit_of';
}
