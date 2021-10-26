import 'dart:convert';

List<Note> noteFromJson(String str) => List<Note>.from(json.decode(str).map((x) => Note.fromJson(x)));

String noteToJson(List<Note> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Note {
  Note({
    this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.type,
    required this.createAt,
  });

  int? id;
  String? title;
  String? description;
  int? price;
  int? type;
  int? createAt;

  Note copy({
    required int id,
    String? title,
    String? description,
    int? price,
    int? type,
    int? createAt,
    String? content,
  }) =>
      Note(
        id: id ,
        title: title,
        description :description,
        price: price,
        type : type,
        createAt : createAt,
      );

  factory Note.fromJson(Map<String, dynamic> json) => Note(
    id: json["_id"] == null ? null : json["_id"],
    title: json["title"],
    description: json["description"] == null ? null : json["description"],
    price: json["price"],
    type: json["type"],
    createAt: json["createAt"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "description": description,
    "price": price,
    "type": type,
    "createAt": createAt,
  };
}

final String tableNotes = 'notes';

class NoteFields {
  static final List<String> values = [
    id, title, description, createAt, price, type
  ];

  static final String id = '_id';
  static final String title = 'title';
  static final String description = 'description';
  static final String createAt = 'createAt';
  static final String price = 'price';
  static final String type = 'type';
}
