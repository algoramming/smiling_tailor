// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CurrencyProfileAdapter extends TypeAdapter<CurrencyProfile> {
  @override
  final int typeId = 0;

  @override
  CurrencyProfile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CurrencyProfile()
      ..name = fields[0] as String
      ..symbol = fields[1] as String
      ..shortForm = fields[2] as String;
  }

  @override
  void write(BinaryWriter writer, CurrencyProfile obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.symbol)
      ..writeByte(2)
      ..write(obj.shortForm);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrencyProfileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
