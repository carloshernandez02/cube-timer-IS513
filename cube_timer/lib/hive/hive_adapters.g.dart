// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_adapters.dart';

// **************************************************************************
// AdaptersGenerator
// **************************************************************************

class SolveAdapter extends TypeAdapter<Solve> {
  @override
  final int typeId = 0;

  @override
  Solve read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Solve(
      scramble: fields[0] as String,
      date: fields[1] as DateTime,
      time: fields[2] as Duration,
      comment: fields[3] as String?,
      tag: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Solve obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.scramble)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.time)
      ..writeByte(3)
      ..write(obj.comment)
      ..writeByte(4)
      ..write(obj.tag);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SolveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
