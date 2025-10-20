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
      coin: fields[0] as String,
      amount: fields[1] as double,
      validator: fields[2] as String,
      lockPeriod: fields[3] as int,
      lockPeriodUnit: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, StakingProgram obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.coin)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.validator)
      ..writeByte(3)
      ..write(obj.lockPeriod)
      ..writeByte(4)
      ..write(obj.lockPeriodUnit);
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
