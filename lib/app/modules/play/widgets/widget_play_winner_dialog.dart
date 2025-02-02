import 'package:flutter/material.dart';
import 'package:flutter_tictactoe_game/app/core/widgets/widget_btn_cf.dart';
import 'package:flutter_tictactoe_game/app/core/widgets/widget_text.dart';
import 'package:flutter_tictactoe_game/app/modules/home/screens/home_screen.dart';
import 'package:flutter_tictactoe_game/app/modules/play/controllers/%20play_controller.dart';
import 'package:get/get.dart';

class WidgetPlayWinnerDialog extends StatelessWidget {
  const WidgetPlayWinnerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final PlayController playController = Get.find<PlayController>();

    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.all(0),
      child: SizedBox(
        width: 320,
        height: 280,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  child: Center(
                child: WidgetText(
                    data:playController.winner.value == 'Draw' ? 'เสมอ !!' : 'ผู้เล่น ${playController.winner} เป็นฝ่ายชนะ !',
                    size: 24,
                    color: Colors.green),
              )),
              WidgetBtnCf(
                  title: 'ตกลง',
                  onPressed: () {
                    Get.offAll(() => const HomeScreen());
                  }),
              const SizedBox(
                height: 10,
              ),
              WidgetBtnCf(
                  title: 'เล่นอีกครั้ง',
                  onPressed: () {
                    Get.back();
                    playController.initGameTable();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
