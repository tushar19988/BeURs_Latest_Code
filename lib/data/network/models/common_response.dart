import 'package:beurs/data/network/models/about_us_reponse.dart';
import 'package:beurs/data/network/models/contact_sync_response.dart';
import 'package:beurs/data/network/models/faq_response.dart';
import 'package:beurs/data/network/models/get_profile_response.dart';
import 'package:beurs/data/network/models/login_response.dart';
import 'package:beurs/data/network/models/past_wishes_response.dart';
import 'package:beurs/data/network/models/social_media_response.dart';
import 'package:beurs/data/network/models/subscription_count_response.dart';
import 'package:beurs/data/network/models/subscription_plan_response.dart';
import 'package:beurs/data/network/models/template_response.dart';
import 'package:beurs/data/network/models/upcoming_birthday_response.dart';

import 'privacy_policy_model.dart';

/// Common response model
class CommonResponse<T> {
  int? status;
  String? statusMsg;
  dynamic data;

  CommonResponse({this.status, this.statusMsg, this.data});

  CommonResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusMsg = json['statusmsg'];
    data = json.containsKey('data') && json['data'] != null
        ? getResponseData(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> mapData = <String, dynamic>{};
    mapData['status'] = status;
    mapData['statusmsg'] = statusMsg;
    if (data != null) {
      mapData['Data'] = data;
      //data['data'] = data!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'CommonResponse{status: $status, statusMessage: $statusMsg, data: $data}';
  }

  /// To get response data either in list or models
  dynamic getResponseData(dynamic json) {
    if (json is List) {
      List<T> list = [];
      for (var element in json) {
        list.add(getModelValue(element));
      }
      return list;
    } else {
      return getModelValue(json);
    }
  }

  /// To retrieve generic specific model value from json
  dynamic getModelValue(dynamic json) {
    switch (T) {
      case const (LoginResponse):
        return LoginResponse.fromJson(json);
      case const (SubscriptionPlanResponse):
        return SubscriptionPlanResponse.fromJson(json);
      case const (SubscriptionCountResponse):
        return SubscriptionCountResponse.fromJson(json);
      case const (FaqResponse):
        return FaqResponse.fromJson(json);
      case const (PastWishesResponse):
        return PastWishesResponse.fromJson(json);
      case const (UpcomingBirthdayResponse):
        return UpcomingBirthdayResponse.fromJson(json);
      case const (TemplateResponse):
        return TemplateResponse.fromJson(json);
      case const (GetProfileResponse):
        return GetProfileResponse.fromJson(json);
      case const (SocialMedialLoginResponse):
        return SocialMedialLoginResponse.fromJson(json);
      case const (ContactSyncResponse):
        return ContactSyncResponse.fromJson(json);
      case const (PrivacyResponse):
        return PrivacyResponse.fromJson(json);
      case const (AboutUsResponse):
        return AboutUsResponse.fromJson(json);
    }
  }
}
