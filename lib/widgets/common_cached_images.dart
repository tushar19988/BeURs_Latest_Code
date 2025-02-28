import 'dart:io';

import 'package:beurs/app/app_colors.dart';
import 'package:beurs/app/app_images.dart';
import 'package:beurs/widgets/common_progress_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CommonCachedImage extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;
  final bool isCircle;
  final BoxFit? boxFit;
  final bool? isBorder;
  final Color? borderColour;
  final BorderRadiusGeometry? borderRadius;
  final String? filePath;

  const CommonCachedImage(
      {Key? key,
      required this.height,
      required this.width,
      required this.imageUrl,
      required this.isCircle,
      this.boxFit,
      this.isBorder,
      this.borderColour,
      this.filePath,
      this.borderRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (filePath != null && filePath!.isNotEmpty) {
      return Image.file(
        File(filePath!),
        fit: boxFit,
      );
    } else if (imageUrl != null && imageUrl!.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        imageBuilder: (context, imageProvider) => Container(
          decoration: isCircle
              ? BoxDecoration(
                  border: isBorder == false ? null : Border.all(color: borderColour ?? AppColors.colorBlack, width: 1),
                  shape: BoxShape.circle,
                  image: DecorationImage(image: imageProvider, fit: boxFit),
                )
              : BoxDecoration(
                  borderRadius: borderRadius,
                  image: DecorationImage(image: imageProvider, fit: boxFit),
                ),
        ),
        width: width,
        height: height,
        progressIndicatorBuilder: (context, url, downloadProgress) => Center(
          child: CommonProgressIndicator(
            value: downloadProgress.progress,
            color: AppColors.colorBlack,
          ),
        ),
        errorWidget: (context, url, error) => Align(
          alignment: Alignment.center,
          child: Container(
            width: width,
            height: height,
            decoration: isCircle
                ? BoxDecoration(
                    border: isBorder == false ? null : Border.all(color: borderColour ?? AppColors.colorBlack, width: 1),
                    shape: BoxShape.circle,
                    image: DecorationImage(image: AssetImage(AppImages.icLogoProfile), fit: boxFit),
                  )
                : BoxDecoration(
                    borderRadius: borderRadius,
                    image: DecorationImage(image: AssetImage(AppImages.icLogoProfile), fit: boxFit),
                  ),
          ),
        ),
      );
    } else {
      return Container(
        width: width,
        height: height,
        decoration: isCircle
            ? BoxDecoration(
                border: isBorder == false ? null : Border.all(color: borderColour ?? AppColors.colorBlack, width: 1),
                shape: BoxShape.circle,
                image: DecorationImage(image: AssetImage(AppImages.icLogoProfile), fit: boxFit),
              )
            : BoxDecoration(
                borderRadius: borderRadius,
                image: DecorationImage(image: AssetImage(AppImages.icLogoProfile), fit: boxFit),
              ),
      );
    }
  }
}
