// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Formats.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FormatsAdapter extends TypeAdapter<Formats> {
  @override
  final int typeId = 2;

  @override
  Formats read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Formats(
      texthtml: fields[0] as String?,
      applicationepubzip: fields[1] as String?,
      applicationxmobipocketebook: fields[2] as String?,
      applicationrdfxml: fields[3] as String?,
      imagejpeg: fields[4] as String?,
      textplaincharsetusascii: fields[5] as String?,
      applicationoctetstream: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Formats obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.texthtml)
      ..writeByte(1)
      ..write(obj.applicationepubzip)
      ..writeByte(2)
      ..write(obj.applicationxmobipocketebook)
      ..writeByte(3)
      ..write(obj.applicationrdfxml)
      ..writeByte(4)
      ..write(obj.imagejpeg)
      ..writeByte(5)
      ..write(obj.textplaincharsetusascii)
      ..writeByte(6)
      ..write(obj.applicationoctetstream);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FormatsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
