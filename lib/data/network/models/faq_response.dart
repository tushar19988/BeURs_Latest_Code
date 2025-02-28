// To parse this JSON data, do
//
//     final faqResponse = faqResponseFromJson(jsonString);

import 'dart:convert';

List<FaqResponse> faqResponseFromJson(String str) => List<FaqResponse>.from(json.decode(str).map((x) => FaqResponse.fromJson(x)));

String faqResponseToJson(List<FaqResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FaqResponse {
  String? id;
  String? faqqes;
  String? faqans;

  FaqResponse({
    this.id,
    this.faqqes,
    this.faqans,
  });

  factory FaqResponse.fromJson(Map<String, dynamic> json) => FaqResponse(
    id: json["id"],
    faqqes: json["faqqes"],
    faqans: json["faqans"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "faqqes": faqqes,
    "faqans": faqans,
  };
}
