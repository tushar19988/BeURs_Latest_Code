// To parse this JSON data, do
//
//     final upComingWishResponse = upComingWishResponseFromJson(jsonString);

import 'dart:convert';

UpComingWishResponse upComingWishResponseFromJson(String str) => UpComingWishResponse.fromJson(json.decode(str));

String upComingWishResponseToJson(UpComingWishResponse data) => json.encode(data.toJson());

class UpComingWishResponse {
  List<Datum>? data;

  UpComingWishResponse({
    this.data,
  });

  factory UpComingWishResponse.fromJson(Map<String, dynamic> json) => UpComingWishResponse(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  String? birthdate;
  List<Userdatum>? userdata;

  Datum({
    this.birthdate,
    this.userdata,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    birthdate: json["birthdate"],
    userdata: json["userdata"] == null ? [] : List<Userdatum>.from(json["userdata"]!.map((x) => Userdatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "birthdate": birthdate,
    "userdata": userdata == null ? [] : List<dynamic>.from(userdata!.map((x) => x.toJson())),
  };
}

class Userdatum {
  String? contactid;
  String? userid;
  int? contactsrno;
  String? contacttype;
  String? contactsubtype;
  String? contactname;
  String? contactno;
  DateTime? dateofbirth;
  String? birthdaymsg;
  String? supparty;
  String? status;
  String? cityname;
  String? statename;
  String? countryname;
  String? countryid;

  Userdatum({
    this.contactid,
    this.userid,
    this.contactsrno,
    this.contacttype,
    this.contactsubtype,
    this.contactname,
    this.contactno,
    this.dateofbirth,
    this.birthdaymsg,
    this.supparty,
    this.status,
    this.cityname,
    this.statename,
    this.countryname,
    this.countryid,
  });

  factory Userdatum.fromJson(Map<String, dynamic> json) => Userdatum(
    contactid: json["contactid"],
    userid: json["userid"],
    contactsrno: json["contactsrno"],
    contacttype: json["contacttype"],
    contactsubtype: json["contactsubtype"],
    contactname: json["contactname"],
    contactno: json["contactno"],
    dateofbirth: json["dateofbirth"] == null ? null : DateTime.parse(json["dateofbirth"]),
    birthdaymsg: json["birthdaymsg"],
    supparty: json["supparty"],
    status: json["status"],
    cityname: json["cityname"],
    statename: json["statename"],
    countryname: json["countryname"],
    countryid: json["countryid"],
  );

  Map<String, dynamic> toJson() => {
    "contactid": contactid,
    "userid": userid,
    "contactsrno": contactsrno,
    "contacttype": contacttype,
    "contactsubtype": contactsubtype,
    "contactname": contactname,
    "contactno": contactno,
    "dateofbirth": dateofbirth?.toIso8601String(),
    "birthdaymsg": birthdaymsg,
    "supparty": supparty,
    "status": status,
    "cityname": cityname,
    "statename": statename,
    "countryname": countryname,
    "countryid": countryid,
  };
}
