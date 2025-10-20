// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staking_program.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StakingProgramAdapter extends TypeAdapter<StakingProgram> {
  @override
  final int typeId = 0;

  @override
  StakingProgram read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StakingProgram(
      id: fields[0] as String,
      name: fields[1] as String,
      apy: fields[2] as double,
      coinId: fields[3] as String?,
      imageUrl: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, StakingProgram obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.apy)
      ..writeByte(3)
      ..write(obj.coinId)
      ..writeByte(4)
      ..write(obj.imageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StakingProgramAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
