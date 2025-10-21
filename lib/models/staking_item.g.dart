// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staking_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StakingItemAdapter extends TypeAdapter<StakingItem> {
  @override
  final int typeId = 2;

  @override
  StakingItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StakingItem(
      coin: fields[0] as String,
      validator: fields[1] as String?,
      balance: fields[2] as double,
      lockPeriodDays: fields[3] as int,
      startDate: fields[4] as DateTime,
      stakingAddress: fields[5] as String?,
      estimatedAPY: fields[6] as double,
    );
  }

  @override
  void write(BinaryWriter writer, StakingItem obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.coin)
      ..writeByte(1)
      ..write(obj.validator)
      ..writeByte(2)
      ..write(obj.balance)
      ..writeByte(3)
      ..write(obj.lockPeriodDays)
      ..writeByte(4)
      ..write(obj.startDate)
      ..writeByte(5)
      ..write(obj.stakingAddress)
      ..writeByte(6)
      ..write(obj.estimatedAPY);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StakingItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
