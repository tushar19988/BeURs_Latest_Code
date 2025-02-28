
import 'package:beurs/app/app_font_weight.dart';
import 'package:beurs/app/app_images.dart';
import 'package:beurs/widgets/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';




import '../app/app_colors.dart';

class CommonAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final VoidCallback? onBackClick;
  final VoidCallback? onTitleTap;
  final double? margin;
  final double? appbarHeight;
  final double? elevation;
  final bool? isBackButton ;

  const CommonAppbar({Key? key, required this.text, this.onBackClick, this.margin, this.elevation, this.onTitleTap, this.appbarHeight,this.isBackButton}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 120.h,width: Get.width,
      decoration:  BoxDecoration(image: const DecorationImage(
          image: AssetImage(AppImages.icAppBarBack),
          fit: BoxFit.fill),borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.r),bottomRight: Radius.circular(10.r))),

      child: Padding(
        padding: EdgeInsets.only(top: 25.h,left: 10.w,right: 70.w),
        child: Row(children: [
          IconButton(onPressed: onBackClick, icon: Icon(Icons.arrow_back_ios_new,color: AppColors.colorWhite,size: 17.sp,)),
        Expanded(child:   Center(child: CommonTextWidget(text: text, textSize: 20.sp,color: AppColors.colorWhite,fontWeight: AppFontWeight.semiBold,)),)
        ],),
      ),
    );



  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(appbarHeight??120.h);
}

