import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tictactoe_game/app/core/widgets/widget_btn_cf.dart';
import 'package:flutter_tictactoe_game/app/core/widgets/widget_text.dart';
import 'package:flutter_tictactoe_game/app/modules/play/controllers/%20play_controller.dart';
import 'package:flutter_tictactoe_game/app/modules/play/screens/play_screen.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class WidgetHomeDialog extends StatefulWidget {
  const WidgetHomeDialog({super.key});

  @override
  State<WidgetHomeDialog> createState() => _WidgetHomeDialogState();
}

class _WidgetHomeDialogState extends State<WidgetHomeDialog> {
  final TextEditingController _gameSizeCtr = TextEditingController();
  final PlayController _playController = Get.find<PlayController>();

  @override
  void initState() {
    super.initState();
    _gameSizeCtr.text = '3';
  }

  @override
  Widget build(BuildContext context) {
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
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  WidgetText(
                      data: 'โหมดผู้เล่น 2 คน', size: 24, color: Colors.black)
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  WidgetText(
                      data: 'กรุณาเลือกขนาดเกม', size: 18, color: Colors.black)
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              SizedBox(
                width: 100,
                child: TextField(
                  controller: _gameSizeCtr,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 14),
                    filled: true,
                    hintText: '',
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      if (value != '') {
                        if (int.parse(value) > 15) {
                          _gameSizeCtr.text = '15';

                          showCupertinoDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CupertinoAlertDialog(
                                title: const Text('ผิดพลาด!'),
                                content: const Text(
                                    'ไม่สามารถสร้างตารางเกิน 15x15 ได้'),
                                actions: <CupertinoDialogAction>[
                                  CupertinoDialogAction(
                                    child: const Text('ตกลง'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                          // } else if (int.parse(value) < 3) {
                          //   _gameSizeCtr.text = '3';
                          //   showCupertinoDialog(
                          //     context: context,
                          //     builder: (BuildContext context) {
                          //       return CupertinoAlertDialog(
                          //         title: const Text('ผิดพลาด!'),
                          //         content: const Text(
                          //             'ไม่สามารถสร้างตารางน้อยกว่า 3x3 ได้'),
                          //         actions: <CupertinoDialogAction>[
                          //           CupertinoDialogAction(
                          //             child: const Text('ตกลง'),
                          //             onPressed: () {
                          //               Navigator.pop(context);
                          //             },
                          //           ),
                          //         ],
                          //       );
                          //     },
                          //   );
                        } else {
                          _gameSizeCtr.text = value;
                        }
                      }
                    });
                  },
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  WidgetText(
                      data:
                          'ขนาดตาราง ${_gameSizeCtr.text == '' ? '0' : _gameSizeCtr.text} x ${_gameSizeCtr.text == '' ? '0' : _gameSizeCtr.text}',
                      size: 18,
                      color: Colors.black)
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              WidgetBtnCf(
                title: 'ตกลง',
                onPressed: _gameSizeCtr.text == '' ||
                        int.parse(_gameSizeCtr.text == ''
                                ? '0'
                                : _gameSizeCtr.text) <
                            3
                    ? null
                    : () {
                        Get.back();
                        if (_playController.gameMode.value ==
                            GameMode.twoPlayer) {
                          _playController.gameSize =
                              int.parse(_gameSizeCtr.text);
                          Get.to(() => const PlayScreen());
                        } else {
                          _playController.gameSize =
                              int.parse(_gameSizeCtr.text);
                          Get.to(() => const PlayScreen());
                        }
                      },
              )
            ],
          ),
        ),
      ),
    );
  }
}
