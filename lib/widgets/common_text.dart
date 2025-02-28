import 'package:beurs/app/app_colors.dart';
import 'package:beurs/app/app_font_weight.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonTextWidget extends StatelessWidget {
  final String text;
  final double? textSize;
  final Color? color;
  final TextDecoration? decoration;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final TextStyle? style;

  const CommonTextWidget({
    super.key,
    required this.text,
    this.textSize,
    this.color,
    this.decoration,
    this.fontWeight,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      softWrap: true,
      maxLines: maxLines,
      style: style ??
          GoogleFonts.inter(
            color: color ?? AppColors.colorBlack,
            fontSize: textSize,
            decoration: decoration,
            fontWeight: fontWeight ?? AppFontWeight.regular,
          ),
    );
  }
}
