// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locale.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocaleProfileAdapter extends TypeAdapter<LocaleProfile> {
  @override
  final int typeId = 1;

  @override
  LocaleProfile read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return LocaleProfile.arabic;
      case 1:
        return LocaleProfile.bengali;
      case 2:
        return LocaleProfile.english;
      case 3:
        return LocaleProfile.hindi;
      case 4:
        return LocaleProfile.urdu;
      default:
        return LocaleProfile.arabic;
    }
  }

  @override
  void write(BinaryWriter writer, LocaleProfile obj) {
    switch (obj) {
      case LocaleProfile.arabic:
        writer.writeByte(0);
        break;
      case LocaleProfile.bengali:
        writer.writeByte(1);
        break;
      case LocaleProfile.english:
        writer.writeByte(2);
        break;
      case LocaleProfile.hindi:
        writer.writeByte(3);
        break;
      case LocaleProfile.urdu:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocaleProfileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
