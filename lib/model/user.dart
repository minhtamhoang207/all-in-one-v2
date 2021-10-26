import 'package:g_json/g_json.dart';

import 'data.dart';

class User {
  User({
    required this.data,
  });

  Data data;

  factory User.fromJson(JSON json) {
    return User(data: Data.fromJson(json['data']));
  }

  Map<String, dynamic> toJson() {
    final json = Map<String, dynamic>();
    json['data'] = data;
    return json;
  }
}
