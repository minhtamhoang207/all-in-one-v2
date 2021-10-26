//part of 'coffee_screen_bloc.dart';

import 'package:bloc_demo/model/note_model/note.dart';

class NoteState{}

class Loading extends NoteState {}

class LoadNoteSuccess extends NoteState {
  List<Note> notes = [];
  int used = 0;
  int balance = 0;
  LoadNoteSuccess({required this.notes, required this.used, required this.balance});
}

class LoadFailed extends NoteState {
  String message;
  LoadFailed(this.message);
}