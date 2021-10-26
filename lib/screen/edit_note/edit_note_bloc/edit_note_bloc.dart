import 'package:bloc_demo/repository/note_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'edit_note_event.dart';
import 'edit_note_state.dart';

class EditNoteBloc extends Bloc<EditNoteEvent, EditNoteState>{
  final NotesDatabase noteRepo;
  EditNoteBloc({required this.noteRepo}): super(EditNoteState());

  @override
  Stream<EditNoteState> mapEventToState(EditNoteEvent event) async*{
    if(event is EditNoteSubmitted){
      yield state.copyWith(formStatus: FormEditStatus.FormSubmitting);
      try{
        await noteRepo.update(event.note);
        yield state.copyWith(formStatus: FormEditStatus.SubmissionSuccess);
      } catch (e){
        print(e);
        yield state.copyWith(formStatus: FormEditStatus.SubmissionFailed);
      }
    }
  }
}