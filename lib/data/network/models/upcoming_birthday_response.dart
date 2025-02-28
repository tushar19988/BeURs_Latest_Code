// To parse this JSON data, do
//
//     final upcomingPastWishesResponse = upcomingPastWishesResponseFromJson(jsonString);

import 'dart:convert';

List<UpcomingBirthdayResponse> upcomingPastWishesResponseFromJson(String str) =>
    List<UpcomingBirthdayResponse>.from(json.decode(str).map((x) => UpcomingBirthdayResponse.fromJson(x)));

String upcomingPastWishesResponseToJson(List<UpcomingBirthdayResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UpcomingBirthdayResponse {
  DateTime? wishdate;
  List<Userdata>? userdata;

  UpcomingBirthdayResponse({
    this.wishdate,
    this.userdata,
  });

  factory UpcomingBirthdayResponse.fromJson(Map<String, dynamic> json) => UpcomingBirthdayResponse(
        wishdate: json["wishdate"] == null ? null : DateTime.parse(json["wishdate"]),
        userdata: json["userdata"] == null ? [] : List<Userdata>.from(json["userdata"]!.map((x) => Userdata.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "wishdate":
            "${wishdate!.year.toString().padLeft(4, '0')}-${wishdate!.month.toString().padLeft(2, '0')}-${wishdate!.day.toString().padLeft(2, '0')}",
        "userdata": userdata == null ? [] : List<dynamic>.from(userdata!.map((x) => x.toJson())),
      };
}

class Userdata {
  String? id;
  String? username;

  Userdata({
    this.id,
    this.username,
  });

  factory Userdata.fromJson(Map<String, dynamic> json) => Userdata(
        id: json["id"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
      };
}
