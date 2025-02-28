// To parse this JSON data, do
//
//     final subscriptionPlanResponse = subscriptionPlanResponseFromJson(jsonString);

import 'dart:convert';

List<SubscriptionPlanResponse> subscriptionPlanResponseFromJson(String str) => List<SubscriptionPlanResponse>.from(json.decode(str).map((x) => SubscriptionPlanResponse.fromJson(x)));

String subscriptionPlanResponseToJson(List<SubscriptionPlanResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubscriptionPlanResponse {
  String? id;
  String? plancnt;
  String? planname;
  String? planprice;
  String? msgcount;
  String? msgcountstr;
  String? validityperiodtime;
  String? validityperiod;
  String? validityperiodtm;
  String? features;
  String? totalCount;

  SubscriptionPlanResponse({
    this.id,
    this.plancnt,
    this.planname,
    this.planprice,
    this.msgcount,
    this.msgcountstr,
    this.validityperiodtime,
    this.validityperiod,
    this.validityperiodtm,
    this.features,
    this.totalCount,
  });

  factory SubscriptionPlanResponse.fromJson(Map<String, dynamic> json) => SubscriptionPlanResponse(
    id: json["id"],
    plancnt: json["plancnt"],
    planname: json["planname"],
    planprice: json["planprice"],
    msgcount: json["msgcount"],
    msgcountstr: json["msgcountstr"],
    validityperiodtime: json["validityperiodtime"],
    validityperiod: json["validityperiod"],
    validityperiodtm: json["validityperiodtm"],
    features: json["features"],
    totalCount: json["TotalCount"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "plancnt": plancnt,
    "planname": planname,
    "planprice": planprice,
    "msgcount": msgcount,
    "msgcountstr": msgcountstr,
    "validityperiodtime": validityperiodtime,
    "validityperiod": validityperiod,
    "validityperiodtm": validityperiodtm,
    "features": features,
    "TotalCount": totalCount,
  };
}
