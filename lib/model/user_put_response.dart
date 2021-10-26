import 'package:g_json/g_json.dart';

class UserPutResponse {
  String name;
  String job;
  String updatedAt;

  UserPutResponse({
    required this.name,
    required this.job,
    required this.updatedAt,
  });

  factory UserPutResponse.fromJson(JSON json) {
    return UserPutResponse(
      name: json['name'].stringValue,
      job: json['job'].stringValue,
      updatedAt: json['updatedAt'].stringValue,
    );
  }

  Map<String, dynamic> toJson() {
    final json = Map<String, dynamic>();
    json['name'] = name;
    json['job'] = job;
    json['updatedAt'] = updatedAt;
    return json;
  }
}
