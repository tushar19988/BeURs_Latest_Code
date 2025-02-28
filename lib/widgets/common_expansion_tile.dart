import 'package:beurs/app/app_colors.dart';
import 'package:beurs/app/app_font_weight.dart';
import 'package:beurs/widgets/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonExpansionTile extends StatelessWidget {
  const CommonExpansionTile({
    super.key,
    this.question,
    this.answer,
  });

  final String? question;
  final String? answer;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        shape: const Border(),
        title: CommonTextWidget(
          text: question ?? "",
          textSize: 16.sp,
          color: AppColors.color626262,
          fontWeight: AppFontWeight.medium,
        ),
        children: [
          ListTile(
            splashColor: Colors.transparent,
            title: CommonTextWidget(
              text: answer ?? "",
              textSize: 16.sp,
              color: AppColors.color626262,
              fontWeight: AppFontWeight.light,
            ),
          )
        ],
      ),
    );
  }
}
