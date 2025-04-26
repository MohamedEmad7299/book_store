// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Authors.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AuthorsAdapter extends TypeAdapter<Authors> {
  @override
  final int typeId = 1;

  @override
  Authors read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Authors(
      name: fields[0] as String?,
      birthYear: fields[1] as int?,
      deathYear: fields[2] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Authors obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.birthYear)
      ..writeByte(2)
      ..write(obj.deathYear);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthorsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
