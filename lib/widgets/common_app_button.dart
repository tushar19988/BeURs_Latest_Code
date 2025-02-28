import 'package:beurs/app/app_colors.dart';
import 'package:beurs/app/app_font_weight.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';





/// Common app button used in whole app
class CommonAppButton extends StatelessWidget {
  final String text;
  final VoidCallback onClick;
  final double? margin;
  final bool? showIcon;
  final Color? appColor;
  final double? fontSize;
  final Color? borderColor;
  final double? width;
  final double? height;
  final double? borderRadius;
  final Color? textColor;
  final Widget? icon;
  final FontWeight? fontWeight;

  const CommonAppButton(
      {Key? key,
      required this.text,
      required this.onClick,
      this.margin,
      this.showIcon,
      this.borderColor,
      this.height,
      this.width,
      this.borderRadius ,
      this.textColor,
      this.appColor,
      this.icon,
        this.fontSize,
      this.fontWeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      borderRadius: BorderRadius.all(Radius.circular(borderRadius??0)),
      child: Container(
        decoration: BoxDecoration(
            color: appColor ?? AppColors.color8A29C4,
            borderRadius: BorderRadius.all(Radius.circular(borderRadius??0)),
            border: Border.all(color: borderColor ?? AppColors.color8A29C4, width: 1.w)),
        height: height ?? 60.h,
        width: width ?? double.infinity,
        margin: EdgeInsets.symmetric(horizontal: margin ?? 0),
        alignment: Alignment.center,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            showIcon == true
                ? icon ??
                    const Icon(
                      Icons.add,
                      color: AppColors.colorWhite,
                    )
                : Container(),
            SizedBox(
              width: 5.w,
            ),
            Text(text, style: TextStyle(fontSize:fontSize?? 18.sp, fontWeight: fontWeight ?? AppFontWeight.semiBold, color: textColor ?? AppColors.colorWhite,fontFamily: "helvetica")),
          ],
        ),
      ),
    );
  }
}
