import 'package:g_json/g_json.dart';

class UserParam {
  String name;
  String job;

  UserParam({
    required this.name,
    required this.job,
  });

  factory UserParam.fromJson(JSON json) {
    return UserParam(
      name: json['name'].stringValue,
      job: json['job'].stringValue,
    );
  }

  Map<String, dynamic> toJson() {
    final json = Map<String, dynamic>();
    json['name'] = name;
    json['job'] = job;
    return json;
  }
}
