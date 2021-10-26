import 'package:g_json/g_json.dart';

class Data {
  int id;
  String email;
  String firstName;
  String lastName;
  String avatar;

  Data({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  factory Data.fromJson(JSON json) {
    return Data(
      id: json['id'].integerValue,
      email: json['id'].stringValue,
      firstName: json['first_name'].stringValue,
      lastName: json['last_name'].stringValue,
      avatar: json['avatar'].stringValue,
    );
  }

  Map<String, dynamic> toJson() {
    final json = Map<String, dynamic>();
    json['id'] = id;
    json['email'] = email;
    json['first_name'] = firstName;
    json['last_name'] = lastName;
    json['avatar'] = avatar;
    return json;
  }
}
