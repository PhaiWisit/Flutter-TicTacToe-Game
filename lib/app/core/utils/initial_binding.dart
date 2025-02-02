
import 'package:flutter_tictactoe_game/app/modules/history/controllers/history_controller.dart';
import 'package:flutter_tictactoe_game/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_tictactoe_game/app/modules/play/controllers/%20play_controller.dart';
import 'package:get/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    
    Get.put(PlayController(), permanent: true);
    Get.put(HomeController(), permanent: true);
    Get.put(HistoryController(), permanent: true);
   
  }
}
