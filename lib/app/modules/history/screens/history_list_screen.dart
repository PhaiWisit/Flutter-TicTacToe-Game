import 'package:flutter/material.dart';
import 'package:flutter_tictactoe_game/app/core/widgets/widget_text.dart';
import 'package:flutter_tictactoe_game/app/data/models/game_history_model.dart';
import 'package:flutter_tictactoe_game/app/modules/history/controllers/history_controller.dart';
import 'package:flutter_tictactoe_game/app/modules/history/screens/history_detail_screen.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class HistoryListScreen extends StatefulWidget {
  const HistoryListScreen({super.key});

  @override
  State<HistoryListScreen> createState() => _HistoryListScreenState();
}

class _HistoryListScreenState extends State<HistoryListScreen> {
  final HistoryController _historyController = Get.find<HistoryController>();

  @override
  void initState() {
    super.initState();

    _historyController.getHistoryList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onDoubleTap: () {
            // test remove all data
            _historyController.onRemoveAllData();
          },
          child: const WidgetText(
              data: 'ประวัติการเล่น', size: 18, color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Obx(() {
              if (_historyController.isLoading.isTrue) {
                return const Center(child: CircularProgressIndicator());
              }

              return SizedBox(
                  width: 100.w,
                  height: 100.h,
                  child: RefreshIndicator(
                    onRefresh: _historyController.getHistoryList,
                    child: ListView.builder(
                      itemCount: _historyController.historyList.length,
                      itemBuilder: (context, index) {
                        var history = _historyController.historyList[index];

                        return _cardHistory(index, history);
                      },
                    ),
                  ));
            }),
          ))
        ],
      ),
    );
  }

  Widget _cardHistory(int index, GameHistoryModel history) {
    return Card(
      child: InkWell(
        onTap: () {
          _historyController.onTapHistory(history.id);
          Get.to(() => const HistoryDetailScreen());
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                 const WidgetText(
                      data: 'ครั้งที่ : ', size: 18, color: Colors.blueAccent),
                  WidgetText(
                      data: '${index + 1}', size: 18, color: Colors.black),
                ],
              ),
              Row(
                children: [
                  const WidgetText(
                      data: 'ขนาดเกม : ', size: 18, color: Colors.blueAccent),
                  WidgetText(
                      data: '${history.gameSize}',
                      size: 18,
                      color: Colors.black),
                ],
              ),
              Row(
                children: [
                  const WidgetText(
                      data: 'โหมด : ', size: 18, color: Colors.blueAccent),
                  WidgetText(
                      data:
                          history.gameMode == 'onePlayer' ? 'ผู้เล่นคนเดียว' : 'ผู้เล่น 2 คน',
                      size: 18,
                      color: Colors.black),
                ],
              ),
              Row(
                children: [
                  const WidgetText(
                      data: 'ผู้ชนะ : ', size: 18, color: Colors.blueAccent),
                  WidgetText(
                      data: history.winner, size: 18, color: Colors.black),
                ],
              ),
              Row(
                children: [
                  const WidgetText(
                      data: 'วันที่ : ', size: 18, color: Colors.blueAccent),
                  WidgetText(
                      data: formatDateToThai(history.timestamp.toString()),
                      size: 18,
                      color: Colors.black),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String formatDateToThai(String timestamp) {
    DateTime date = DateTime.parse(timestamp);
    final DateFormat dateFormat = DateFormat('d MMMM yyyy', 'th_TH');
    return dateFormat.format(date);
  }
}
