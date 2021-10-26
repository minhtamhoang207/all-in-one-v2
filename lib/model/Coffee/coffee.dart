// import 'package:g_json/g_json.dart';
//
// List<Coffee> coffeeFromJson(String str) => List<Coffee>.from(JSON.parse(str).listValue);
//
// class Coffee {
//   String title;
//   String description;
//   List<dynamic>? ingredients;
//   int id;
//
//   Coffee({
//     required this.title,
//     required this.description,
//     required this.ingredients,
//     required this.id,
//   });
//
//   factory Coffee.fromJson(JSON json){
//     return Coffee(
//         title: json['title'].stringValue,
//         description: json['description'].stringValue,
//         ingredients: json['ingredients'].listObject,
//         id: json['id'].integerValue
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     final json = Map<String, dynamic>();
//     json['title'] = title;
//     json['description'] = description;
//     json['ingredients'] = ingredients;
//     json['id'] = id;
//     return json;
//   }
// }
// import 'dart:convert';

// List<Coffee> coffeeFromJson(String str) => List<Coffee>.from(json.decode(str).map((x) => Coffee.fromJson(x)));
//
// String coffeeToJson(List<Coffee> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Coffee {
  Coffee({
    required this.title,
    required this.description,
    required this.ingredients,
    required this.id,
  });

  String title;
  String description;
  List<String> ingredients;
  int id;

  factory Coffee.fromJson(Map<String, dynamic> json) => Coffee(
    title: json["title"],
    description: json["description"],
    ingredients: List<String>.from(json["ingredients"].map((x) => x)),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "ingredients": List<dynamic>.from(ingredients.map((x) => x)),
    "id": id,
  };
}

