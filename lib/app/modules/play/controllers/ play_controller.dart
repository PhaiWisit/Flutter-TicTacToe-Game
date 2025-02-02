import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_tictactoe_game/app/data/models/game_history_model.dart';
import 'package:flutter_tictactoe_game/app/data/repository/game_history_local_repository.dart';
import 'package:flutter_tictactoe_game/app/modules/play/widgets/widget_play_winner_dialog.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

enum GameMode { twoPlayer, onePlayer }

class PlayController extends GetxController {
  var gameMode = GameMode.twoPlayer.obs;
  int gameSize = 0;
  RxList gameTable = [].obs;
  RxString winner = ''.obs;
  RxString turnPlayer = ''.obs;
  RxList winIndex = [].obs;
  List tapIndex = [];

  final GameHistoryLocalRepository gameHistoryLocalRepository =
      GameHistoryLocalRepository(Hive.box<GameHistoryModel>('game_history'));

  void initGameTable() {
    log('init Game Table');
    winner.value = '';
    turnPlayer.value = 'X';
    winIndex.value = [];
    tapIndex = [];
    gameTable.value = [];
    gameTable.value = List.generate(gameSize * gameSize, (index) {
      return '';
    });
  }

  // Event
  void onSelectGameMode(GameMode mode) {
    gameMode.value = mode;
  }

  void onTap(int index, BuildContext context) {
    if (gameTable[index] == '' && winner.value == '') {
      gameTable[index] = _getCurrentPlayer();
      _getTurnPlayer();
      _checkWinner();
      tapIndex.add(index);

      if (winner.value != '') {
        onPlayFinished(context);
      }

      if (winner.value == '' && gameMode.value == GameMode.onePlayer) {
        Future.delayed(const Duration(milliseconds: 100), () {
          int botMove = _getBotMove();
          if (botMove != -1) {
            gameTable[botMove] = 'O';
            _getTurnPlayer();
            _checkWinner();
            tapIndex.add(botMove);
            if (winner.value != '') {
              onPlayFinished(context);
            }
          }
        });
      }
    } else {}
  }

  void onPlayFinished(context) {
    log('On Play Finished ==========');
    log('gameSize : ${gameSize}');
    log('gameTable : ${gameTable}');
    log('gameMode : ${gameMode.value.toString().split('.')[1]}');
    log('winner : ${winner}');
    log('winIndex : ${winIndex}');
    log('tapIndex : ${tapIndex}');
    log('timestamp : ${DateTime.now().subtract(Duration(days: 2)).toString()}');

    int newId = gameHistoryLocalRepository.gameBox.length + 1;
    gameHistoryLocalRepository.saveGame(GameHistoryModel(
      id: newId,
      gameSize: gameSize,
      gameTable: List<String>.from(gameTable),
      winner: winner.value,
      winIndex: List<int>.from(winIndex),
      tapIndex: List<int>.from(tapIndex),
      gameMode: gameMode.toString().split('.')[1],
      timestamp: DateTime.now(),
    ));

    if (winner.value == 'Draw') {
      winIndex.value = [];
    }

    showPopupDialog(context);
  }

  // Function
  String _getCurrentPlayer() {
    final xCount = gameTable.where((value) => value == 'X').length;
    final oCount = gameTable.where((value) => value == 'O').length;
    return xCount <= oCount ? 'X' : 'O';
  }

  String _getTurnPlayer() {
    if (turnPlayer.value == 'X') {
      turnPlayer.value = 'O';
      return turnPlayer.value;
    } else {
      turnPlayer.value = 'X';
      return turnPlayer.value;
    }
  }

  void _checkWinner() {
    for (int i = 0; i < gameSize; i++) {
      if (_checkWinnerRow(i)) {
        log('Win row : ${i + 1}');
        return;
      }
      if (_checkWinnerColumn(i)) {
        log('Win column : ${i + 1}');
        return;
      }
    }

    if (_checkWinnerDiagonalLeft()) {
      log('Win diagonal : (\\)');
      return;
    }
    if (_checkWinnerDiagonalRight()) {
      log('Win diagonal : (/)');
      return;
    }

    if (!gameTable.contains('')) {
      winIndex.clear();
      winner.value = 'Draw';
      return;
    }
  }

  bool _checkWinnerRow(int row) {
    int startIndex = row * gameSize;
    String first = gameTable[startIndex];
    winIndex.clear();
    if (first == '') {
      return false;
    } else {
      winIndex.add(startIndex);
    }
    for (int i = 1; i < gameSize; i++) {
      if (gameTable[startIndex + i] != first) {
        return false;
      }
      winIndex.add(startIndex + i);
    }

    log(winIndex.toString());

    winner.value = first;
    return true;
  }

  bool _checkWinnerColumn(int col) {
    String first = gameTable[col];
    winIndex.clear();
    if (first == '') {
      return false;
    } else {
      winIndex.add(col);
    }
    for (int i = 1; i < gameSize; i++) {
      if (gameTable[col + i * gameSize] != first) {
        return false;
      }
      winIndex.add(col + i * gameSize);
    }
    winner.value = first;
    return true;
  }

  bool _checkWinnerDiagonalLeft() {
    String first = gameTable[0];
    winIndex.clear();

    if (first == '') {
      return false;
    } else {
      winIndex.add(0);
    }

    for (int i = 1; i < gameSize; i++) {
      if (gameTable[i * (gameSize + 1)] != first) {
        return false;
      } else {
        winIndex.add(i * (gameSize + 1));
      }
    }
    winner.value = first;
    return true;
  }

  bool _checkWinnerDiagonalRight() {
    String first = gameTable[gameSize - 1];
    winIndex.clear();
    if (first == '') {
      return false;
    } else {
      winIndex.add(gameSize - 1);
    }
    for (int i = 1; i < gameSize; i++) {
      if (gameTable[(i + 1) * (gameSize - 1)] != first) {
        return false;
      } else {
        winIndex.add((i + 1) * (gameSize - 1));
      }
    }
    winner.value = first;
    return true;
  }

  // Bot Function
  int _getBotMove() {
    // 1. ถ้าเดินแล้วชนะ -> เลือกช่องนั้น
    for (int i = 0; i < gameTable.length; i++) {
      if (gameTable[i] == '') {
        gameTable[i] = 'O';
        if (_isWinningMove('O')) {
          gameTable[i] = '';
          return i;
        }
        gameTable[i] = '';
      }
    }

    // 2. ถ้าผู้เล่นกำลังจะชนะ -> บล็อก
    for (int i = 0; i < gameTable.length; i++) {
      if (gameTable[i] == '') {
        gameTable[i] = 'X';
        if (_isWinningMove('X')) {
          gameTable[i] = '';
          return i;
        }
        gameTable[i] = '';
      }
    }

    // 3. ถ้าไม่มีที่ต้องบล็อก เลือกจุดที่ดีที่สุด
    List<int> preferredMoves = [
      (gameSize * gameSize) ~/ 2, // ตรงกลาง
      0, gameSize - 1, // มุมบนซ้าย & ขวา
      gameTable.length - gameSize, gameTable.length - 1, // มุมล่างซ้าย & ขวา
    ];

    for (int move in preferredMoves) {
      if (move < gameTable.length && gameTable[move] == '') return move;
    }

    // 4. เลือกจุดว่างแรกที่เจอ
    return gameTable.indexWhere((value) => value == '');
  }

  bool _isWinningMove(String player) {
    for (int i = 0; i < gameSize; i++) {
      if (_checkWinCondition(i * gameSize, 1, player) || 
          _checkWinCondition(i, gameSize, player)) 
      {
        return true;
      }
    }
    return _checkWinCondition(0, gameSize + 1, player) || 
        _checkWinCondition(
            gameSize - 1, gameSize - 1, player); 
  }

  bool _checkWinCondition(int startIndex, int step, String player) {
    for (int i = 0; i < gameSize; i++) {
      if (gameTable[startIndex + i * step] != player) return false;
    }
    return true;
  }

  // Utils
  Color getWinColor(int index) {
    if (winner.value != '') {
      if (winIndex.contains(index)) {
        return Colors.green;
      } else {
        return Colors.white;
      }
    } else {
      return Colors.white;
    }
  }

  void showPopupDialog(context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WidgetPlayWinnerDialog();
      },
    );
  }
}
