import 'package:beurs/app/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CommonProgressIndicator extends StatelessWidget {
  final Color? color;
  final Color? backGroundColor;
  final double strokeWidth;
  final double? value;

  const CommonProgressIndicator({
    Key? key,
    this.color,
    this.backGroundColor = Colors.transparent,
    this.strokeWidth = 3.0,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SpinKitFadingCircle(
      color: AppColors.color8125B8,
      size: 50.0,
    );
  }
}
