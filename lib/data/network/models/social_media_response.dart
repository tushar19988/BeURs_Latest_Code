// To parse this JSON data, do
//
//     final socialMedialLoginResponse = socialMedialLoginResponseFromJson(jsonString);

import 'dart:convert';

SocialMedialLoginResponse socialMedialLoginResponseFromJson(String str) => SocialMedialLoginResponse.fromJson(json.decode(str));

String socialMedialLoginResponseToJson(SocialMedialLoginResponse data) => json.encode(data.toJson());

class SocialMedialLoginResponse {
  String? id;
  String? username;
  String? mobileno;
  String? emailid;
  dynamic password;
  String? maritalstatus;
  String? cityname;
  String? statename;
  String? countryid;
  DateTime? birthdate;
  dynamic annvrdate;
  String? supparty;
  bool? usersubscription;
  String? accessToken;
  String? userimage;
  bool? isProfile;
//commit
  SocialMedialLoginResponse({
    this.id,
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
    this.usersubscription,
    this.accessToken,
    this.userimage,
    this.isProfile,
  });

  factory SocialMedialLoginResponse.fromJson(Map<String, dynamic> json) => SocialMedialLoginResponse(
        id: json["id"],
        username: json["username"],
        mobileno: json["mobileno"],
        emailid: json["emailid"],
        password: json["password"],
        maritalstatus: json["maritalstatus"],
        cityname: json["cityname"],
        statename: json["statename"],
        countryid: json["countryid"],
        birthdate: json["birthdate"] == null ? DateTime.now() : DateTime.parse(json["birthdate"]),
        annvrdate: json["annvrdate"],
        supparty: json["supparty"],
        usersubscription: json["usersubscription"],
        accessToken: json["access_token"],
        userimage: json["userimage"],
        isProfile: json["is_profile"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "mobileno": mobileno,
        "emailid": emailid,
        "password": password,
        "maritalstatus": maritalstatus,
        "cityname": cityname,
        "statename": statename,
        "countryid": countryid,
        "birthdate":
            "${birthdate!.year.toString().padLeft(4, '0')}-${birthdate!.month.toString().padLeft(2, '0')}-${birthdate!.day.toString().padLeft(2, '0')}",
        "annvrdate": annvrdate,
        "supparty": supparty,
        "usersubscription": usersubscription,
        "access_token": accessToken,
        "userimage": userimage,
        "is_profile": isProfile,
      };
}
