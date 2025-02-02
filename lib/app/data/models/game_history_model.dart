import 'package:hive/hive.dart';

part 'game_history_model.g.dart';

@HiveType(typeId: 0)
class GameHistoryModel extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  int gameSize;

  @HiveField(2)
  List<dynamic> gameTable;

  @HiveField(3)
  String winner;

  @HiveField(4)
  List<dynamic> winIndex;

  @HiveField(5)
  List<dynamic> tapIndex;

  @HiveField(6)
  String gameMode;

  @HiveField(7)
  DateTime timestamp;

  GameHistoryModel({
    required this.id,
    required this.gameSize,
    required this.gameTable,
    required this.winner,
    required this.winIndex,
    required this.tapIndex,
    required this.gameMode,
    required this.timestamp,
  });

  factory GameHistoryModel.fromJson(Map<String, dynamic> json) {
    return GameHistoryModel(
      id: json['id'],
      gameSize: json['gameSize'],
      gameTable: List<String>.from(json['gameTable']),
      winner: json['winner'],
      winIndex: List<int>.from(json['winIndex']),
      tapIndex: List<int>.from(json['tapIndex']),
      gameMode: json['gameMode'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'gameSize': gameSize,
      'gameTable': gameTable,
      'winner': winner,
      'winIndex': winIndex,
      'tapIndex': tapIndex,
      'gameMode': gameMode,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
