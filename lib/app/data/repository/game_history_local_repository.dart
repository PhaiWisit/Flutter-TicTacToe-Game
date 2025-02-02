import 'package:flutter_tictactoe_game/app/data/models/game_history_model.dart';
import 'package:hive/hive.dart';

class GameHistoryLocalRepository {
  final Box<GameHistoryModel> gameBox;

  GameHistoryLocalRepository(this.gameBox);

  Future<void> saveGame(GameHistoryModel game) async {
    await gameBox.put(game.id, game);
  }

  GameHistoryModel? getGame(dynamic id) {
    return gameBox.get(id);
  }

  List<GameHistoryModel> getAllGames() {
    return gameBox.values.toList();
  }

  void removeAllGames() {
    gameBox.clear();
  }
}