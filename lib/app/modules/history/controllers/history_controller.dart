import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_tictactoe_game/app/data/models/game_history_model.dart';
import 'package:flutter_tictactoe_game/app/data/repository/game_history_local_repository.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class HistoryController extends GetxController {
  RxBool isLoading = false.obs;
  var historyList = <GameHistoryModel>[].obs;
  var historyDetail = Rx<GameHistoryModel?>(null);
  var replayDetail = Rx<GameHistoryModel?>(null);

  final GameHistoryLocalRepository gameHistoryLocalRepository =
      GameHistoryLocalRepository(Hive.box<GameHistoryModel>('game_history'));

  Future<void> getHistoryList() async {
    isLoading.value = true;
    var gameList = gameHistoryLocalRepository.getAllGames();
    historyList.assignAll(gameList);
    isLoading.value = false;
  }

  onTapHistory(id) {
    historyDetail.value = gameHistoryLocalRepository.getGame(id);

    log('On Tap History ==========');
    log('gameSize : ${historyDetail.value!.gameSize}');
    log('gameTable : ${historyDetail.value!.gameTable}');
    log('gameMode : ${historyDetail.value!.gameMode}');
    log('winner : ${historyDetail.value!.winner}');
    log('winIndex : ${historyDetail.value!.winIndex}');
    log('tapIndex : ${historyDetail.value!.tapIndex}');
    log('timestamp : ${historyDetail.value!.timestamp}');

    replayDetail.value = GameHistoryModel(
      id: historyDetail.value!.id,
      gameSize: historyDetail.value!.gameSize,
      gameTable: List.from(historyDetail.value!.gameTable),
      winner: historyDetail.value!.winner,
      winIndex: List.from(historyDetail.value!.winIndex),
      tapIndex: List.from(historyDetail.value!.tapIndex),
      gameMode: historyDetail.value!.gameMode,
      timestamp: historyDetail.value!.timestamp,
    );

    replayDetail.value!.gameTable = List.generate(
      replayDetail.value!.gameSize * replayDetail.value!.gameSize,
      (index) => '',
    );

    replayIndex = 0;
    replayDetail.refresh();
  }

  // Replay Function
  int replayIndex = 0;
  void onPressedNextReplay() {
    if (replayIndex < replayDetail.value!.tapIndex.length) {
      onReplayTap(replayDetail.value!.tapIndex[replayIndex]);
      replayIndex++;
      replayDetail.refresh();
    }
  }

  void onPressedBackReplay() {
    if (replayIndex > 0) {
      replayIndex--;
      onReplayUnTap(replayDetail.value!.tapIndex[replayIndex]);
      replayDetail.refresh();
    }
  }

  void onReplayTap(int index) {
    replayDetail.value!.gameTable[index] = _getCurrentPlayer();
  }

  void onReplayUnTap(int index) {
    replayDetail.value!.gameTable[index] = '';
  }

  String _getCurrentPlayer() {
    final xCount =
        replayDetail.value!.gameTable.where((value) => value == 'X').length;
    final oCount =
        replayDetail.value!.gameTable.where((value) => value == 'O').length;
    return xCount <= oCount ? 'X' : 'O';
  }

  // Utils
  Color getWinColor(int index) {
    if (historyDetail.value!.winner != '') {
      if (historyDetail.value!.winIndex.contains(index)) {
        return Colors.green;
      } else {
        return Colors.white;
      }
    } else {
      return Colors.white;
    }
  }

  String formatDateToThai(DateTime date) {
    final DateFormat dateFormat = DateFormat('d MMMM yyyy', 'th_TH');
    return dateFormat.format(date);
  }

  // Test
  void onRemoveAllData() {
    gameHistoryLocalRepository.removeAllGames();
  }
}
