// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  String? userid;
  String? username;
  String? mobileno;
  String? emailid;
  dynamic password;
  String? maritalstatus;
  String? cityname;
  String? statename;
  String? countryid;
  DateTime? birthdate;
  DateTime? annvrdate;
  String? supparty;
  String? userimage;
  String? accessToken;
  bool? isSubscription;
  bool? isProfile;

  LoginResponse(
      {this.userid,
      this.username,
      this.mobileno,
      this.emailid,
      this.password,
      this.maritalstatus,
      this.cityname,
      this.statename,
      this.countryid,
      this.birthdate,
      this.annvrdate,
      this.supparty,
      this.userimage,
      this.accessToken,
      this.isSubscription,
      this.isProfile});

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        userid: json["id"],
        username: json["username"],
        mobileno: json["mobileno"],
        emailid: json["emailid"],
        password: json["password"],
        maritalstatus: json["maritalstatus"],
        cityname: json["cityname"],
        statename: json["statename"],
        countryid: json["countryid"],
        birthdate: json["birthdate"] == null || json["birthdate"] == "" ? null : DateTime.parse(json["birthdate"]),
        annvrdate: json["annvrdate"] == null ? null : DateTime.parse(json["annvrdate"]),
        supparty: json["supparty"],
        userimage: json["userimage"] ?? "",
        accessToken: json["access_token"],
        isSubscription: json["usersubscription"],
        isProfile: json["is_profile"],
      );

  Map<String, dynamic> toJson() => {
        "id": userid,
        "username": username,
        "mobileno": mobileno,
        "emailid": emailid,
        "password": password,
        "maritalstatus": maritalstatus,
        "cityname": cityname,
        "statename": statename,
        "countryid": countryid,
        "birthdate": birthdate,
        "annvrdate": annvrdate?.toIso8601String(),
        "supparty": supparty,
        "userimage": userimage,
        "access_token": accessToken,
        "usersubscription": isSubscription,
        "is_profile": isProfile,
      };
}
