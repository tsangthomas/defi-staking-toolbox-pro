// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crypto_holding.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CryptoHoldingAdapter extends TypeAdapter<CryptoHolding> {
  @override
  final int typeId = 1;

  @override
  CryptoHolding read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CryptoHolding(
      coin: fields[0] as String,
      name: fields[1] as String,
      amount: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, CryptoHolding obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.coin)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.amount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CryptoHoldingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
