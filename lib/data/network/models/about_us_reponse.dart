import 'dart:convert';

AboutUsResponse dataFromJson(String str) =>
    AboutUsResponse.fromJson(json.decode(str));

String dataToJson(AboutUsResponse data) => json.encode(data.toJson());

class AboutUsResponse {
  AboutUsResponse({
    this.htmlData,
  });

  AboutUsResponse.fromJson(dynamic json) {
    htmlData = json['html_data'];
  }

  String? htmlData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['html_data'] = htmlData;
    return map;
  }
}
