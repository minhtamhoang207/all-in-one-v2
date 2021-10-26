import 'package:g_json/g_json.dart';

class CoffeeParam {
  String type;

  CoffeeParam({
    required this.type,
  });

  factory CoffeeParam.fromJson(JSON json) {
    return CoffeeParam(
      type: json['name'].stringValue,
    );
  }

  Map<String, dynamic> toJson() {
    final json = Map<String, dynamic>();
    json['type'] = type;
    return json;
  }
}
