import 'package:bloc_demo/model/note_model/note.dart';

abstract class AddNoteEvent {}

class NoteSubmitted extends AddNoteEvent {
  final String title;
  final String description;
  final int price;
  final int type;
  final int createAt;
  NoteSubmitted(
      this.title,
      this.description,
      this.price,
      this.type,
      this.createAt);

  Note get note => Note(
      title : this.title,
      description: this.description,
      price: this.price,
      type: this.type,
      createAt: this.createAt
  );
}
