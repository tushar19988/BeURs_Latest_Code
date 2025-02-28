import 'package:beurs/app/app_class.dart';
import 'package:beurs/data/network/client/api_client.dart';
import 'package:beurs/data/network/client/api_provider.dart';
import 'package:beurs/data/network/models/common_response.dart';
import 'package:beurs/data/network/models/faq_response.dart';
import 'package:dartz/dartz.dart';

class AppRepository extends ApiProvider {
  Future<Either<String, dynamic>?> getFaqData() async {
    var response = await getMethod<FaqResponse>(ApiClient.faq);
    return response?.fold((l) => Left(l), (r) => Right(r as dynamic));
  }

  Future<Either<String, CommonResponse>?> review(
      Map<String, dynamic> params) async {
    AppClass().showLoading(true);
    var response = await postMethod<CommonResponse>(ApiClient.review, params);
    AppClass().showLoading(false);
    return response?.fold((l) => Left(l), (r) => Right(r as CommonResponse));
  }

  Future<Either<String, CommonResponse>?> contactUs(
      Map<String, dynamic> params) async {
    AppClass().showLoading(true);
    var response =
        await postMethod<CommonResponse>(ApiClient.contactUs, params);
    AppClass().showLoading(false);
    return response?.fold((l) => Left(l), (r) => Right(r as CommonResponse));
  }

  Future<Either<String, CommonResponse>?> sendMessageTemplate(
      Map<String, dynamic> params) async {
    AppClass().showLoading(true);
    var response =
    await postMethod<CommonResponse>(ApiClient.sendMessageTemplate, params);
    AppClass().showLoading(false);
    return response?.fold((l) => Left(l), (r) => Right(r as CommonResponse));
  }
}
