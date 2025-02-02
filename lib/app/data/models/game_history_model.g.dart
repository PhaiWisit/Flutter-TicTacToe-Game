// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_history_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GameHistoryModelAdapter extends TypeAdapter<GameHistoryModel> {
  @override
  final int typeId = 0;

  @override
  GameHistoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GameHistoryModel(
      id: fields[0] as int,
      gameSize: fields[1] as int,
      gameTable: (fields[2] as List).cast<String>(),
      winner: fields[3] as String,
      winIndex: (fields[4] as List).cast<int>(),
      tapIndex: (fields[5] as List).cast<int>(),
      gameMode: fields[6] as String,
      timestamp: fields[7] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, GameHistoryModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.gameSize)
      ..writeByte(2)
      ..write(obj.gameTable)
      ..writeByte(3)
      ..write(obj.winner)
      ..writeByte(4)
      ..write(obj.winIndex)
      ..writeByte(5)
      ..write(obj.tapIndex)
      ..writeByte(6)
      ..write(obj.gameMode)
      ..writeByte(7)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameHistoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
