// To parse this JSON data, do
//
//     final subscriptionCountResponse = subscriptionCountResponseFromJson(jsonString);

import 'dart:convert';

SubscriptionCountResponse subscriptionCountResponseFromJson(String str) => SubscriptionCountResponse.fromJson(json.decode(str));

String subscriptionCountResponseToJson(SubscriptionCountResponse data) => json.encode(data.toJson());

class SubscriptionCountResponse {
  String? id;
  String? usersubscription;
  String? usersubscriptionCount;
  String? subscriptionCountStatus;
  String? subscriptionname;

  SubscriptionCountResponse({
    this.id,
    this.usersubscription,
    this.usersubscriptionCount,
    this.subscriptionCountStatus,
    this.subscriptionname,
  });

  factory SubscriptionCountResponse.fromJson(Map<String, dynamic> json) => SubscriptionCountResponse(
        id: json["id"],
        usersubscription: json["usersubscription"],
        usersubscriptionCount: json["usersubscriptionCount"],
        subscriptionCountStatus: json["subscriptionCountStatus"],
        subscriptionname: json["subscriptionname"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "usersubscription": usersubscription,
        "usersubscriptionCount": usersubscriptionCount,
        "subscriptionCountStatus": subscriptionCountStatus,
        "subscriptionname": subscriptionname,
      };
}
