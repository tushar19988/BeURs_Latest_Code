import 'dart:convert';

/// status : 1
/// statusmsg : "Success"
/// data : [{"question":"Where can I find a list of the tools and software I need to use for my role?","answer":"Soluta nobis eligendi optio cumque nihil impedit minus quod maxime placeat facere possimus omnis voluptas assumenda est omnis dolor repellendus. Temporibus autem quibusdam."},{"question":"Whom do I contact if I encounter technical issues with my onboarding?","answer":""},{"question":"How do I find LGBTQIA+ support groups within the organization?","answer":""},{"question":"How do I know more about employee wellness programs?","answer":""}]
//
// PrivacyPolicyModel privacyPolicyModelFromJson(String str) =>
//     PrivacyPolicyModel.fromJson(json.decode(str));
//
// String privacyPolicyModelToJson(PrivacyPolicyModel data) =>
//     json.encode(data.toJson());
//
// class PrivacyPolicyModel {
//   PrivacyPolicyModel({
//     this.status,
//     this.statusmsg,
//     this.data,
//   });
//
//   PrivacyPolicyModel.fromJson(dynamic json) {
//     status = json['status'];
//     statusmsg = json['statusmsg'];
//     if (json['data'] != null) {
//       data = [];
//       json['data'].forEach((v) {
//         data?.add(PrivacyData.fromJson(v));
//       });
//     }
//   }
//
//   int? status;
//   String? statusmsg;
//   List<PrivacyData>? data;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['status'] = status;
//     map['statusmsg'] = statusmsg;
//     if (data != null) {
//       map['data'] = data?.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }
// }

/// question : "Where can I find a list of the tools and software I need to use for my role?"
/// answer : "Soluta nobis eligendi optio cumque nihil impedit minus quod maxime placeat facere possimus omnis voluptas assumenda est omnis dolor repellendus. Temporibus autem quibusdam."

PrivacyResponse dataFromJson(String str) =>
    PrivacyResponse.fromJson(json.decode(str));

String dataToJson(PrivacyResponse data) => json.encode(data.toJson());

class PrivacyResponse {
  PrivacyResponse({
    this.question,
    this.answer,
  });

  PrivacyResponse.fromJson(dynamic json) {
    question = json['question'];
    answer = json['answer'];
  }

  String? question;
  String? answer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['question'] = question;
    map['answer'] = answer;
    return map;
  }
}
