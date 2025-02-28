// To parse this JSON data, do
//
//     final pastWishesResponse = pastWishesResponseFromJson(jsonString);

import 'dart:convert';

List<PastWishesResponse> pastWishesResponseFromJson(String str) =>
    List<PastWishesResponse>.from(json.decode(str).map((x) => PastWishesResponse.fromJson(x)));

String pastWishesResponseToJson(List<PastWishesResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PastWishesResponse {
  DateTime? wishdate;
  List<Userdata>? userdata;

  PastWishesResponse({
    this.wishdate,
    this.userdata,
  });

  factory PastWishesResponse.fromJson(Map<String, dynamic> json) => PastWishesResponse(
        wishdate: json["wishdate"] == null ? null : DateTime.parse(json["wishdate"]),
        userdata: json["userdata"] == null ? [] : List<Userdata>.from(json["userdata"]!.map((x) => Userdata.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "wishdate": wishdate,
        "userdata": userdata == null ? [] : List<dynamic>.from(userdata!.map((x) => x.toJson())),
      };
}

class Userdata {
  String? id;
  String? username;
  String? birthdaymsg;

  Userdata({
    this.id,
    this.username,
    this.birthdaymsg,
  });

  factory Userdata.fromJson(Map<String, dynamic> json) => Userdata(
        id: json["id"],
        username: json["username"],
        birthdaymsg: json["birthdaymsg"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "birthdaymsg": birthdaymsg,
      };
}
