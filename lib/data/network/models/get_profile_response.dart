// To parse this JSON data, do
//
//     final getProfileResponse = getProfileResponseFromJson(jsonString);

import 'dart:convert';

GetProfileResponse getProfileResponseFromJson(String str) =>
    GetProfileResponse.fromJson(json.decode(str));

String getProfileResponseToJson(GetProfileResponse data) =>
    json.encode(data.toJson());

class GetProfileResponse {
  String? id;
  String? username;
  String? mobileno;
  String? countryCode;
  String? emailid;
  DateTime? birthdate;
  String? userimage;

  GetProfileResponse({
    this.id,
    this.username,
    this.mobileno,
    this.countryCode,
    this.emailid,
    this.birthdate,
    this.userimage,
  });

  factory GetProfileResponse.fromJson(Map<String, dynamic> json) =>
      GetProfileResponse(
        id: json["id"],
        username: json["username"],
        mobileno: json["mobileno"],
        countryCode: json["country_code"],
        emailid: json["emailid"],
        birthdate: json["birthdate"] == null
            ? null
            : DateTime.parse(json["birthdate"]),
        userimage: json["userimage"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "mobileno": mobileno,
        "country_code": countryCode,
        "emailid": emailid,
        "birthdate": birthdate?.toIso8601String(),
        "userimage": userimage,
      };
}
