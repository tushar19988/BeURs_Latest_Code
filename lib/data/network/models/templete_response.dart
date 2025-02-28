// To parse this JSON data, do
//
//     final templateResponse = templateResponseFromJson(jsonString);

import 'dart:convert';

List<TemplateResponse> templateResponseFromJson(String str) => List<TemplateResponse>.from(json.decode(str).map((x) => TemplateResponse.fromJson(x)));

String templateResponseToJson(List<TemplateResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TemplateResponse {
  int? id;
  String? msgstr;

  TemplateResponse({
    this.id,
    this.msgstr,
  });

  factory TemplateResponse.fromJson(Map<String, dynamic> json) => TemplateResponse(
    id: json["id"],
    msgstr: json["msgstr"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "msgstr": msgstr,
  };
}
