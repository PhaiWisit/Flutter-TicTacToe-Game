import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WidgetText extends StatelessWidget {
  const WidgetText({
    super.key,
    required this.data,
    required this.size,
    required this.color,
     this.weight,
    this.spacing,
    this.maxLines,
    this.textAlign,
    this.textDecoration,
  });

  final String data;
  final double size;
  final Color color;
  final FontWeight? weight;
  final double? spacing;

  final int? maxLines;
  final TextAlign? textAlign;
  final TextDecoration? textDecoration;

  @override
  Widget build(BuildContext context) {

    return Text(
      data,
      style: TextStyle(
          fontFamily: 'Prompt',
          color: color,
          fontWeight: weight,
          letterSpacing: spacing,
          fontSize:  size,
          decoration: textDecoration ?? TextDecoration.none),
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }
}
