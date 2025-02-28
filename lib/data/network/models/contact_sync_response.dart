// To parse this JSON data, do
//
//     final contactSyncResponse = contactSyncResponseFromJson(jsonString);

import 'dart:convert';

ContactSyncResponse contactSyncResponseFromJson(String str) => ContactSyncResponse.fromJson(json.decode(str));

String contactSyncResponseToJson(ContactSyncResponse data) => json.encode(data.toJson());

class ContactSyncResponse {
  String? count;

  ContactSyncResponse({
    this.count,
  });

  factory ContactSyncResponse.fromJson(Map<String, dynamic> json) => ContactSyncResponse(
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "count": count,
      };
}
