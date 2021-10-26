import 'package:bloc_demo/model/note_model/note.dart';

abstract class EditNoteEvent {}

class EditNoteSubmitted extends EditNoteEvent {
  final int id;
  final String title;
  final String description;
  final int price;
  final int type;
  final int createAt;
  EditNoteSubmitted(
      this.id,
      this.title,
      this.description,
      this.price,
      this.type,
      this.createAt);

  Note get note => Note(
      id: this.id,
      title : this.title,
      description: this.description,
      price: this.price,
      type: this.type,
      createAt: this.createAt
  );
}
