import 'package:bloc/bloc.dart';
import 'package:bloc_demo/model/note_model/note.dart';
import 'package:bloc_demo/repository/note_repository.dart';
import 'note_event.dart';
import 'note_state.dart';


class NoteBloc extends Bloc<NoteEvent, NoteState> {
  NoteBloc() : super(NoteState());

  @override
  Stream<NoteState> mapEventToState(NoteEvent event) async* {
    if(event is GetNoteEvent){
      yield(Loading());
      List<Note> notes;
      int used;
      int balance;
      try{
        notes = await NotesDatabase.instance.readAllNotes();
        var temp = await NotesDatabase.instance.used();
        var temp2 = await NotesDatabase.instance.balance();
        used = temp[0]["PRICE"]??0;
        balance = temp2[0]["PRICE"]??0;
        yield(LoadNoteSuccess(notes: notes, used: used, balance: balance));
      } catch(e){
        yield(LoadFailed(e.toString()));
      }
    }
  }
}
