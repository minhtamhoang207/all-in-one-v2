import 'package:bloc_demo/model/note_model/note.dart';
import 'package:bloc_demo/repository/note_repository.dart';
import 'package:bloc_demo/screen/add_note/add_note_bloc/add_note_event.dart';
import 'package:bloc_demo/screen/add_note/add_note_bloc/add_note_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNoteBloc extends Bloc<AddNoteEvent, AddNoteState>{
  final NotesDatabase noteRepo;
  AddNoteBloc({required this.noteRepo}): super(AddNoteState());

  @override
  Stream<AddNoteState> mapEventToState(AddNoteEvent event) async*{
    if(event is NoteSubmitted){
      print("submitted");
      yield state.copyWith(formStatus: FormSubmissionStatus.FormSubmitting);
      try{
        print("adding");
        await noteRepo.create(event.note);
        print("success");
        yield state.copyWith(formStatus: FormSubmissionStatus.SubmissionSuccess);
      } catch (e){
        print(e);
        yield state.copyWith(formStatus: FormSubmissionStatus.SubmissionFailed);
      }
    }
  }
}