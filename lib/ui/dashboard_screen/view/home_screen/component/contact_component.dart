import 'dart:developer';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:beurs/app/app_colors.dart';
import 'package:beurs/app/app_font_weight.dart';
import 'package:beurs/ui/dashboard_screen/view/home_screen/home_controller.dart';
import 'package:beurs/utility/utils.dart';
import 'package:beurs/widgets/common_app_button.dart';
import 'package:beurs/widgets/common_app_input.dart';
import 'package:beurs/widgets/common_progress_indicator.dart';
import 'package:beurs/widgets/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ContactComponent extends StatelessWidget {
  final HomeController homeController;

  const ContactComponent({super.key, required this.homeController});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return homeController.isLoadingContact.value
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CommonProgressIndicator(),
                const SizedBox(height: 15),
                SizedBox(
                  height: 100.0,
                  child: AnimatedTextKit(
                    repeatForever: true,
                    isRepeatingAnimation: true,
                    animatedTexts: [
                      Utils.fadeAnimatedText(
                          text:
                              "Hang tight! We are gathering all your contacts to make sure no birthday goes unnoticed."),
                      Utils.fadeAnimatedText(
                          text:
                              "Tip: Personalize your birthday message with a fond memory or an inside joke to make your loved ones feel extra special."),
                      Utils.fadeAnimatedText(
                          text:
                              "While we sync your contacts, why not have some fun? Guess which celebrity you share your birthday with!"),
                    ],
                  ),
                ),
              ],
            )
          : Column(
              children: [
                SizedBox(height: 20.h),
                CommonAppInput(
                  height: 60.h,
                  hintText: "Search Contact",
                  textEditingController: homeController.searchController,
                  contentPaddingVertical: 20.h,
                  filledColor: Colors.transparent,
                  borderColor: AppColors.color9F45D4,
                  borderRadius: 12.0.r,
                  prefixIcon: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(Icons.search),
                  ),
                  textInputType: TextInputType.text,
                  onChanged: (value) {
                    homeController.getContactSearchData(value);
                  },
                ),
                // Text("Total Contact ${homeController.contactData.length}"),
                homeController.contactList.isEmpty
                    ? Expanded(
                        child: Center(
                          child: CommonTextWidget(
                            text: "No Contact Found",
                            textSize: 16.sp,
                          ),
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.only(top: 20.h),
                          itemCount: homeController
                              .searchContactData(
                                  contact: homeController.contactData)
                              .length,
                          itemBuilder: (BuildContext context, int index) {
                            final contact = homeController.searchContactData(
                                contact: homeController.contactData)[index];
                            final phoneNumbers = contact.phones;

                            return GestureDetector(
                              onTap: () {
                                if (phoneNumbers.isNotEmpty &&
                                    homeController.usersubscription.value ==
                                        "true" &&
                                    homeController
                                            .subscriptionCountStatus.value ==
                                        "true") {
                                  showDialogs(
                                      contact.displayName ?? "No Name",
                                      phoneNumbers.first.number!.replaceAll(
                                          RegExp(
                                              r'[-\s()\s+\s/\s,/s#/s./s*/s]'),
                                          ''));
                                } else {
                                  Utils.showFreeMessageCompleteDialog(context);
                                }
                              },
                              child: Container(
                                color: AppColors.colorWhite,
                                child: phoneNumbers.isEmpty
                                    ? Container()
                                    : Column(
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                height: 50.w,
                                                width: 50.w,
                                                decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color:
                                                        AppColors.color9F45D4),
                                                child: Center(
                                                  child: CommonTextWidget(
                                                    text: _getInitials(
                                                        contact.displayName),
                                                    textSize: 16.sp,
                                                    color: AppColors.colorWhite,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 10.w),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    CommonTextWidget(
                                                      text: contact
                                                              .displayName ??
                                                          phoneNumbers
                                                              .first.number!
                                                              .replaceAll(
                                                                  RegExp(
                                                                      r'[-\s()\s+\s/\s,/s#/s./s*/s]'),
                                                                  ''),
                                                      textSize: 17.sp,
                                                      fontWeight:
                                                          AppFontWeight.light,
                                                    ),
                                                    SizedBox(height: 5.h),
                                                    CommonTextWidget(
                                                      text: phoneNumbers
                                                          .first.number!
                                                          .replaceAll(
                                                              RegExp(
                                                                  r'[-\s()\s+\s/\s,/s#/s./s*/s]'),
                                                              ''),
                                                      textSize: 12.sp,
                                                      fontWeight:
                                                          AppFontWeight.light,
                                                      color:
                                                          AppColors.color9C9C9C,
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(height: 15.h),
                                          Divider(
                                              thickness: 1.h,
                                              color: AppColors.colorE9E9E9),
                                          SizedBox(height: 15.h),
                                        ],
                                      ),
                              ),
                            );
                          },
                        ),
                      ),
              ],
            );
    });
  }

  String _getInitials(String? displayName) {
    if (displayName == null || displayName.isEmpty) return "??";

    List<String> nameParts = displayName.split(" ");
    String initials = "";

    // Get the first letter of the first and last name
    if (nameParts.isNotEmpty) {
      initials += nameParts[0][0];
    }
    if (nameParts.length > 1) {
      initials += nameParts[nameParts.length - 1][0];
    }

    return initials.toUpperCase();
  }

  void showDialogs(String contactName, String contactNumber) async {
    await showDialog(
      context: Get.context as BuildContext,
      builder: (context) => AlertDialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
        contentPadding: EdgeInsets.zero,
        backgroundColor: AppColors.colorWhite,
        content: Container(
          height: 500.h,
          width: Get.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: AppColors.colorWhite,
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonTextWidget(
                          text: "Wish a birthday",
                          textSize: 18.sp,
                          fontWeight: AppFontWeight.regular,
                          color: AppColors.color8A29C4,
                        ),
                        const Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Divider(thickness: 1.h, color: Colors.grey.withOpacity(0.5)),
                  SizedBox(height: 10.h),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.only(bottom: 20.h),
                      itemCount: homeController.templateResponse.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Obx(() {
                          return GestureDetector(
                            onTap: () {
                              homeController.selectedMessage.value = index;
                              homeController.selectedMessageDescription.value =
                                  homeController
                                          .templateResponse[index].msgstr ??
                                      "";
                            },
                            child: Container(
                              width: Get.width,
                              color:
                                  homeController.selectedMessage.value == index
                                      ? const Color(0xffF7E9FF)
                                      : AppColors.colorWhite,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 15.h, horizontal: 21.w),
                                child: CommonTextWidget(
                                  text: homeController
                                              .templateResponse[index].msgstr ==
                                          ""
                                      ? "No Message"
                                      : homeController
                                          .templateResponse[index].msgstr!,
                                  textSize: 14.r,
                                ),
                              ),
                            ),
                          );
                        });
                      },
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 15.h,
                left: 0,
                right: 0,
                child: Center(
                  child: CommonAppButton(
                    text: "Send",
                    onClick: () {
                      homeController.sendMessageTemplate(
                          contactName, contactNumber);
                    },
                    borderRadius: 10.r,
                    height: 45.h,
                    width: 114.w,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
