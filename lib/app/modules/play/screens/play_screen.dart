import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_tictactoe_game/app/core/widgets/widget_text.dart';
import 'package:flutter_tictactoe_game/app/modules/play/controllers/%20play_controller.dart';
import 'package:get/get.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({
    super.key,
  });

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  final PlayController _playController = Get.find<PlayController>();

  @override
  void initState() {
    super.initState();
    _playController.initGameTable();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('เล่นเกม', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(() {
          log(_playController.gameTable.toString());

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
                      data: ' คิวของผู้เล่น ${_playController.turnPlayer} ',
                      size: 32,
                      color: Colors.purple),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: _playController.gameSize,
                    childAspectRatio: 1,
                  ),
                  itemCount:
                      _playController.gameSize * _playController.gameSize,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        _playController.onTap(index,context);
                     

                      },
                      child: Container(
                        margin: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          color: _playController.getWinColor(index),
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Center(
                          child: Obx(() {
                            return Text(
                              _playController.gameTable[index],
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            );
                          }),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

}
