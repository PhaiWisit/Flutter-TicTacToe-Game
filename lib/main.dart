import 'package:flutter/material.dart';
import 'package:flutter_tictactoe_game/app/core/utils/initial_binding.dart';
import 'package:flutter_tictactoe_game/app/data/models/game_history_model.dart';
import 'package:flutter_tictactoe_game/app/modules/home/screens/home_screen.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initHive();

  await initializeDateFormatting('th_TH', null);

  runApp(const MyApp());
}

Future<void> initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(GameHistoryModelAdapter());
  await Hive.openBox<GameHistoryModel>('game_history');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        initialBinding: InitialBinding(),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Tic Tac Toe',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      );
    });
  }
}
