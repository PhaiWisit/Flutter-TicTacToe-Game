
import 'package:flutter/material.dart';
import 'package:flutter_tictactoe_game/app/core/widgets/widget_text.dart';
import 'package:sizer/sizer.dart';

class WidgetBtnCf extends StatelessWidget {
  const WidgetBtnCf({
    super.key,
    required this.title,
    this.onPressed,
    this.backgroundColor = Colors.blue,
    this.textColor = Colors.white,
    this.icon,
    this.fontSize = 18,
    this.height = 54,
    this.borderColor = Colors.blue,
    this.borderWidth = 0,
    this.disabledBackgroundColor,
    this.width,
    this.defaultWidth = true,
    this.isLoading = false,
  });

  final String title;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? disabledBackgroundColor;
  final Color? textColor;
  final Icon? icon;
  final double? height;
  final Color? borderColor;
  final double? borderWidth;
  final double fontSize;
  final double? width;
  final bool defaultWidth;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? (defaultWidth ? 95.w : null),
      height: height,
      child: ElevatedButton(
          onPressed: onPressed == null
              ? null
              : () {
                  if (!isLoading) {
                    onPressed?.call();
                  }
                },
          style: ElevatedButton.styleFrom(
              disabledBackgroundColor: disabledBackgroundColor,
              backgroundColor: backgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  color: borderColor!,
                  width: borderWidth!,
                ),
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                icon!,
                const SizedBox(width: 8),
              ],
              if (isLoading)
                const CircularProgressIndicator(
                  color: Colors.white,
                ),
              if (!isLoading)
                WidgetText(
                    data: title,
                    size: fontSize,
                    color: textColor!,
                    weight: FontWeight.w500),
            ],
          )),
    );
  }
}
