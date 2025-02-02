
import 'package:flutter/material.dart';
import 'package:flutter_tictactoe_game/app/core/widgets/widget_btn_cf.dart';
import 'package:flutter_tictactoe_game/app/core/widgets/widget_text.dart';
import 'package:flutter_tictactoe_game/app/data/models/game_history_model.dart';
import 'package:flutter_tictactoe_game/app/modules/history/controllers/history_controller.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class HistoryDetailScreen extends StatefulWidget {
  const HistoryDetailScreen({super.key});

  @override
  State<HistoryDetailScreen> createState() => _HistoryDetailScreenState();
}

class _HistoryDetailScreenState extends State<HistoryDetailScreen> {
  final HistoryController _historyController = Get.find<HistoryController>();

  bool isShowReplay = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const WidgetText(data: 'รายละเอียด', size: 18, color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(() {
          if (_historyController.isLoading.isTrue) {
            return const CircularProgressIndicator();
          }

          var result = _historyController.historyDetail;
          var replay = _historyController.replayDetail;

          return Column(
            children: [
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: WidgetText(
                      data: result.value!.winner == 'Draw'
                          ? 'เสมอ !!'
                          : 'ผู้เล่น ${result.value!.winner} เป็นฝ่ายชนะ !',
                      size: 32,
                      color: Colors.purple),
                ),
              ),
              const SizedBox(height: 20),
              isShowReplay ? _tableReplay(replay.value) : _tableResult(result.value),
              isShowReplay
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        WidgetBtnCf(
                          title: '',
                          backgroundColor: Colors.amber,
                          icon: const Icon(Icons.arrow_back_ios_new),
                          width: 45.w,
                          onPressed: () {
                            _historyController.onPressedBackReplay();
                          },
                        ),
                        WidgetBtnCf(
                          title: '',
                           backgroundColor: Colors.amber,
                          icon: const Icon(Icons.arrow_forward_ios),
                          width: 45.w,
                          onPressed: () {
                            _historyController.onPressedNextReplay();
                          },
                        ),
                      ],
                    )
                  : Container(),
              const SizedBox(height: 20),
              isShowReplay
                  ? WidgetBtnCf(
                      title: 'ดูผลการเล่น',
                      onPressed: () {
                        setState(() {
                          isShowReplay = false;
                        });
                      },
                    )
                  : WidgetBtnCf(
                      title: 'ดูการเล่นย้อนหลัง',
                      onPressed: () {
                        setState(() {
                          isShowReplay = true;
                        });
                      },
                    ),
              const SizedBox(height: 20),
            ],
          );
        }),
      ),
    );
  }

  Widget _tableReplay(GameHistoryModel? details) {
    if(details == null){
      return const Expanded(child: Center(child: WidgetText(data: 'ไม่มีการเล่นย้อนหลัง', size: 16, color: Colors.black),));
    }

    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: details.gameSize,
          childAspectRatio: 1,
        ),
        itemCount: details.gameSize * details.gameSize,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              color: _historyController.replayIndex == details.tapIndex.length ? _historyController.getWinColor(index) : Colors.white,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Center(
                child: Text(
              details.gameTable[index],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            )),
          );
        },
      ),
    );
  }

  Widget _tableResult(GameHistoryModel? details) {
     if(details == null){
      return const Expanded(child: Center(child: WidgetText(data: 'ไม่มีผลการเล่น', size: 16, color: Colors.black),));
    }
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: details.gameSize,
          childAspectRatio: 1,
        ),
        itemCount: details.gameSize * details.gameSize,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              color: _historyController.getWinColor(index),
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Center(
                child: Text(
              details.gameTable[index],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            )),
          );
        },
      ),
    );
  }
}
