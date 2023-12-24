// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WalletModelAdapter extends TypeAdapter<WalletModel> {
  @override
  final int typeId = 13;

  @override
  WalletModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WalletModel(
      name: fields[0] as String,
      balance: fields[1] as double,
      date: fields[2] as int,
      time: fields[3] as int,
      paymentMethod: fields[4] as String,
      category: fields[5] as String,
      encomeSource: fields[6] as String,
      valueCategory: fields[7] as String,
      repeatWallet: fields[8] as String?,
      walletPeriod: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, WalletModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.balance)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.time)
      ..writeByte(4)
      ..write(obj.paymentMethod)
      ..writeByte(5)
      ..write(obj.category)
      ..writeByte(6)
      ..write(obj.encomeSource)
      ..writeByte(7)
      ..write(obj.valueCategory)
      ..writeByte(8)
      ..write(obj.repeatWallet)
      ..writeByte(9)
      ..write(obj.walletPeriod);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WalletModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
