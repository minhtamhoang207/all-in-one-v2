import 'package:g_json/g_json.dart';

class UserPostResponse {
  String id;
  String name;
  String job;
  String createdAt;

  UserPostResponse({
    required this.id,
    required this.name,
    required this.job,
    required this.createdAt,
  });

  factory UserPostResponse.fromJson(JSON json) {
    return UserPostResponse(
      id: json['id'].stringValue,
      name: json['name'].stringValue,
      job: json['job'].stringValue,
      createdAt: json['createdAt'].stringValue,
    );
  }

  Map<String, dynamic> toJson() {
    final json = Map<String, dynamic>();
    json['id'] = id;
    json['name'] = name;
    json['job'] = job;
    json['createdAt'] = createdAt;
    return json;
  }
}
