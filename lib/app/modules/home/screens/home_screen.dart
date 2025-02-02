import 'package:flutter/material.dart';
import 'package:flutter_tictactoe_game/app/core/widgets/widget_btn_cf.dart';
import 'package:flutter_tictactoe_game/app/core/widgets/widget_text.dart';
import 'package:flutter_tictactoe_game/app/modules/history/screens/history_list_screen.dart';
import 'package:flutter_tictactoe_game/app/modules/home/widgets/widget_home_dialog.dart';
import 'package:flutter_tictactoe_game/app/modules/play/controllers/%20play_controller.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PlayController playController = Get.find<PlayController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SizedBox(
        width: 100.w,
        height: 100.h,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const WidgetText(
                data: 'Flutter',
                size: 32,
                color: Colors.black,
                weight: FontWeight.bold,
              ),
              const WidgetText(
                data: 'Tic Tac Toe',
                size: 32,
                color: Colors.purple,
                weight: FontWeight.bold,
              ),
              Image.asset('lib/assets/images/image_home.png'),
              Padding(
                padding: EdgeInsets.only(bottom: 2.h),
                child: WidgetBtnCf(
                  title: 'ผู้เล่น 2 คน',
                  onPressed: () {
                    playController.onSelectGameMode(GameMode.twoPlayer);
                    showPopupDialog(context);
                  },
                ),
              ),
               Padding(
                padding: EdgeInsets.only(bottom: 2.h),
                child: WidgetBtnCf(
                  title: 'ผู้เล่นคนเดียว',
                  onPressed: () {
                     playController.onSelectGameMode(GameMode.onePlayer);
                    showPopupDialog(context);
                  },
                ),
              ),
               Padding(
                padding: EdgeInsets.only(bottom: 2.h),
                child: WidgetBtnCf(
                  title: 'ประวัติการเล่น',
                  backgroundColor: Colors.green,
                  onPressed: () {
                    Get.to(()=> const HistoryListScreen());
                  },
                ),
              )
            ],
          ),
        ),
      )),
    );
  }


  void showPopupDialog(context){
    showDialog(context: context, builder: (context) {
      return const WidgetHomeDialog();
    },);
  }
}
