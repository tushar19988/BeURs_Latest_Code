import 'package:beurs/app/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// Common app input used in whole app
class CommonAppInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final bool isPassword;
  final bool isEnable;
  final bool isMobileNumber;
  final bool isOtp;
  final bool autofocus;
  final double borderRadius;
  final String hintText;
  final String headerText;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final Widget? suffixIcon;
  final Widget? suffixWidget;
  final VoidCallback? onSuffixClick;
  final VoidCallback? onSubmitClick;
  final Function(String)? onChanged;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;
  final Widget? prefixIcon;
  final InputDecoration? inputDecoration;
  final Color? filledColor;
  final Color? borderColor;
  final Color? textColor;
  final Color? hintColor;
  final double? height;
  final double? width;
  final int? maxLine;
  final int? maxLength;
  final bool? isPasswordLength;
  final bool readOnly;
  final FocusNode? focusNode;
  final double? contentPadding;
  final double? contentPaddingVertical;
  final bool isEmail;

  const CommonAppInput({
    super.key,
    required this.textEditingController,
    this.textInputType = TextInputType.text,
    this.isPassword = false,
    this.isMobileNumber = false,
    this.isOtp = false,
    this.isEnable = true,
    this.isPasswordLength = false,
    this.borderRadius = 0,
    this.hintText = '',
    this.headerText = '',
    this.hintStyle,
    this.labelStyle,
    this.suffixIcon,
    this.suffixWidget,
    this.onSuffixClick,
    this.onSubmitClick,
    this.onChanged,
    this.inputDecoration,
    this.prefixIcon,
    this.focusNode,
    this.readOnly = false,
    this.autofocus = false,
    this.textInputAction = TextInputAction.next,
    this.textCapitalization = TextCapitalization.none,
    this.filledColor,
    this.borderColor,
    this.textColor,
    this.hintColor,
    this.height,
    this.width,
    this.maxLine,
    this.maxLength,
    this.contentPadding,
    this.contentPaddingVertical,
    this.isEmail = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      keyboardType: textInputType,
      obscureText: isPassword,
      maxLines: maxLine ?? 1,
      enabled: isEnable,
      maxLength: maxLength,
      cursorColor: AppColors.color013567,
      focusNode: focusNode,
      autofocus: autofocus,
      textCapitalization: textCapitalization,
      textInputAction: textInputAction,
      inputFormatters: isPasswordLength!
          ? <TextInputFormatter>[
              LengthLimitingTextInputFormatter(14),
              FilteringTextInputFormatter.deny(RegExp(r'\s')),
            ]
          //: null,
          : isMobileNumber
              ? <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(10),
                  //FilteringTextInputFormatter.digitsOnly,
                ]
              : isOtp
                  ? <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(4),
                      FilteringTextInputFormatter.digitsOnly,
                    ]
                  : <TextInputFormatter>[
                      // FilteringTextInputFormatter.deny(RegExp(r'\s')),
                    ],
      autocorrect: true,
      readOnly: readOnly,
      style: GoogleFonts.montserrat(
        color: textColor ?? AppColors.color013567,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      ),
      onChanged: onChanged,
      decoration: inputDecoration ??
          InputDecoration(
            hintText: hintText,
            suffix: suffixWidget,
            hintStyle: GoogleFonts.montserrat(
              color: hintColor ?? AppColors.color939393,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
            suffixIcon: suffixIcon != null
                ? Padding(
                    padding: EdgeInsets.only(left: 15.w, right: 21.w),
                    child: suffixIcon,
                  )
                : null,
            contentPadding: EdgeInsets.symmetric(
              vertical: contentPaddingVertical ?? 0.0,
              horizontal: contentPadding ?? 20.w,
            ),
            filled: true,
            isDense: true,
            prefixIconConstraints: BoxConstraints(
              maxHeight: ScreenUtil().screenHeight,
              maxWidth: ScreenUtil().screenWidth,
              minHeight: 0,
              minWidth: 0,
            ),
            prefixIcon: prefixIcon,
            fillColor: filledColor ?? AppColors.color9C9C9C.withOpacity(0.18),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  borderRadius != 0 ? borderRadius : 12.0.r,
                ),
              ),
              borderSide: BorderSide(
                color: borderColor ?? AppColors.colorWhite,
                width: 1.w,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  borderRadius != 0 ? borderRadius : 12.0.r,
                ),
              ),
              borderSide: BorderSide(
                color: AppColors.colorWhite,
                width: 1.w,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  borderRadius != 0 ? borderRadius : 12.0.r,
                ),
              ),
              borderSide: BorderSide(
                color: AppColors.colorWhite,
                width: 1.w,
              ),
            ),
          ),
    );
  }
}
