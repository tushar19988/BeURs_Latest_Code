import 'dart:convert';
import 'dart:io';
import 'package:beurs/app/app_class.dart';
import 'package:beurs/data/network/client/api_client.dart';
import 'package:beurs/data/network/client/api_provider.dart';
import 'package:beurs/data/network/models/about_us_reponse.dart';
import 'package:beurs/data/network/models/common_response.dart';
import 'package:beurs/data/network/models/contact_sync_response.dart';
import 'package:beurs/data/network/models/get_profile_response.dart';
import 'package:beurs/data/network/models/login_response.dart';
import 'package:beurs/data/network/models/past_wishes_response.dart';
import 'package:beurs/data/network/models/privacy_policy_model.dart';
import 'package:beurs/data/network/models/social_media_response.dart';
import 'package:beurs/data/network/models/subscription_count_response.dart';
import 'package:beurs/data/network/models/subscription_plan_response.dart';
import 'package:beurs/data/network/models/template_response.dart';
import 'package:beurs/data/network/models/upcoming_birthday_response.dart';
import 'package:dartz/dartz.dart';

class UserRepository extends ApiProvider {
  Future<Either<String, CommonResponse>?> signUp(
      Map<String, dynamic> params) async {
    AppClass().showLoading(true);
    var response = await postMethod<CommonResponse>(ApiClient.signUp, params);
    AppClass().showLoading(false);
    return response?.fold((l) => Left(l), (r) => Right(r as CommonResponse));
  }

  Future<Either<String, CommonResponse>?> signIn(
      Map<String, dynamic> params) async {
    AppClass().showLoading(true);
    var response = await postMethod<LoginResponse>(ApiClient.signIn, params,
        isFullResponse: true);
    AppClass().showLoading(false);
    return response?.fold((l) => Left(l), (r) => Right(r as CommonResponse));
  }

  //  Future<Either<String, CommonResponse>?> numberOtpVerification(
  //     Map<String, dynamic> params) async {
  //   AppClass().showLoading(true);
  //   var response =
  //       await postMethod<LoginResponse>(ApiClient.numberVerifyOtp, jsonEncode(params));
  //   AppClass().showLoading(false);
  //   return response?.fold((l) => Left(l), (r) => Right(r as CommonResponse));
  // }

  Future<Either<String, CommonResponse>?> numberOtpVerification(
      Map<String, dynamic> params) async {
    AppClass().showLoading(true);
    var response = await postMethod<LoginResponse>(
      ApiClient.numberVerifyOtp,
      jsonEncode(params),
      isFullResponse: true,
    );
    AppClass().showLoading(false);

    // Handle the response and ensure proper casting
    // return response?.fold(
    //     (l) => Left(l),
    //     (r) => Right(CommonResponse<LoginResponse>.fromJson(r)));

    return response?.fold((l) => Left(l), (r) => Right(r as CommonResponse));
  }

  Future<Either<String, CommonResponse>?> sendOtp(
      Map<String, dynamic> params) async {
    AppClass().showLoading(true);
    var response = await postMethod<CommonResponse>(
        ApiClient.loginWithOtp, params,
        isFullResponse: true);
    AppClass().showLoading(false);
    return response?.fold((l) => Left(l), (r) => Right(r as CommonResponse));
  }

  Future<Either<String, SocialMedialLoginResponse>?> socialLogin(
      Map<String, dynamic> params) async {
    var response = await postMethod<SocialMedialLoginResponse>(
        ApiClient.socialSignIn, params,
        isFormData: false);
    return response?.fold(
        (l) => Left(l), (r) => Right(r as SocialMedialLoginResponse));
  }

  Future<Either<String, dynamic>?> getSubscriptionPlan() async {
    var response = await getMethod<SubscriptionPlanResponse>(
        ApiClient.getSubscriptionPlan);
    return response?.fold((l) => Left(l), (r) => Right(r as dynamic));
  }

  Future<Either<String, dynamic>?> getPrivacyPolicy() async {
    var response = await getMethod<AboutUsResponse>(ApiClient.privacyPolicy);
    return response?.fold((l) => Left(l), (r) => Right(r as dynamic));
  }

  Future<Either<String, dynamic>?> getTermsConditions() async {
    var response = await getMethod<AboutUsResponse>(ApiClient.termsConditions);
    return response?.fold((l) => Left(l), (r) => Right(r as dynamic));
  }

  Future<Either<String, dynamic>?> getFaq() async {
    var response = await getMethod<PrivacyResponse>(ApiClient.getFaq);
    return response?.fold((l) => Left(l), (r) => Right(r as dynamic));
  }

  Future<Either<String, dynamic>?> getAbout() async {
    var response = await getMethod<AboutUsResponse>(ApiClient.getAboutUs);
    return response?.fold((l) => Left(l), (r) => Right(r as dynamic));
  }

  Future<Either<String, dynamic>?> getSubscriptionCount() async {
    var response = await getMethod<SubscriptionCountResponse>(
        ApiClient.getSubscriptionCount);
    return response?.fold((l) => Left(l), (r) => Right(r as dynamic));
  }

  Future<Either<String, dynamic>?> getUserProfile() async {
    AppClass().showLoading(true);
    var response =
        await getMethod<GetProfileResponse>(ApiClient.getUserProfile);
    AppClass().showLoading(false);
    return response?.fold((l) => Left(l), (r) => Right(r as dynamic));
  }

  Future<Either<String, dynamic>?> updateProfile(
    Map<String, String> params,
    Map<String, File> files,
  ) async {
    AppClass().showLoading(true);

    // Call postMethod and handle the response
    var response = await postMethod<String>(
      ApiClient.updateProfile,
      params,
      files: files,
      isFormData: true,
      forSendMessage: false,
    );

    AppClass().showLoading(false);

    return response?.fold(
      (failure) => Left(failure), // Handle the failure case
      (result) {
        if (result is CommonResponse) {
          // If the result is a CommonResponse, handle it
          if (result.status == 1) {
            // If the status is successful, return the data or status message
            return Right(result.data ?? result.statusMsg);
          } else {
            // If the status indicates failure, return the status message
            return Left(result.statusMsg ?? "Unknown error");
          }
        } else {
          // If the result is not of type CommonResponse, return an error
          return Left("Unexpected response type: ${result.runtimeType}");
        }
      },
    );
  }

  Future<Either<String, CommonResponse>?> forgotPassword(
      Map<String, dynamic> params) async {
    AppClass().showLoading(true);
    var response = await postMethod<CommonResponse>(
        ApiClient.forgotPassword, params,
        isFullResponse: true);
    AppClass().showLoading(false);
    return response?.fold((l) => Left(l), (r) => Right(r as CommonResponse));
  }

  Future<Either<String, CommonResponse>?> otpVerification(
      Map<String, dynamic> params) async {
    AppClass().showLoading(true);
    var response =
        await postMethod<CommonResponse>(ApiClient.otpVerification, params);
    AppClass().showLoading(false);
    return response?.fold((l) => Left(l), (r) => Right(r as CommonResponse));
  }

  Future<Either<String, CommonResponse>?> changePassword(
      Map<String, dynamic> params) async {
    AppClass().showLoading(true);
    var response =
        await postMethod<CommonResponse>(ApiClient.resetPassword, params);
    AppClass().showLoading(false);
    return response?.fold((l) => Left(l), (r) => Right(r as CommonResponse));
  }

  Future<Either<String, dynamic>?> getPastWishes() async {
    var response = await getMethod<PastWishesResponse>(ApiClient.getPastWishes);
    return response?.fold((l) => Left(l), (r) => Right(r as dynamic));
  }

  Future<Either<String, dynamic>?> getUpComingWishes() async {
    var response =
        await getMethod<UpcomingBirthdayResponse>(ApiClient.getUpComingWish);
    return response?.fold((l) => Left(l), (r) => Right(r as dynamic));
  }

  Future<Either<String, dynamic>?> getTemplate() async {
    var response = await getMethod<TemplateResponse>(ApiClient.getTemplate);
    return response?.fold((l) => Left(l), (r) => Right(r as dynamic));
  }

  Future<Either<String, CommonResponse>?> createPayment(
      Map<String, dynamic> params) async {
    AppClass().showLoading(true);
    var response =
        await postMethod<CommonResponse>(ApiClient.addPayment, params);
    AppClass().showLoading(false);
    return response?.fold((l) => Left(l), (r) => Right(r as CommonResponse));
  }

  Future<Either<String, CommonResponse>?> syncContact(dynamic params) async {
    var response = await postMethod<ContactSyncResponse>(
        ApiClient.contactSync, params,
        isFullResponse: true, isFormData: true, forSendMessage: true);
    return response?.fold((l) => Left(l), (r) => Right(r as CommonResponse));
  }
}
