import 'package:bloc_demo/model/note_model/note.dart';
import 'package:bloc_demo/repository/note_repository.dart';
import 'package:bloc_demo/screen/edit_note/edit_note_bloc/edit_note_bloc.dart';
import 'package:bloc_demo/utils/utils.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'edit_note_bloc/edit_note_event.dart';
import 'edit_note_bloc/edit_note_state.dart';


class EditNoteScreen extends StatefulWidget {
  final Note note;
  EditNoteScreen({Key? key, required this.note}) : super(key: key);

  @override
  _EditNoteScreenState createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {

  NotesDatabase _notesDatabase = NotesDatabase.instance;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EditNoteBloc(noteRepo: _notesDatabase),
      child: EditNoteHomeScreen(widget.note),
    );
  }
}

class EditNoteHomeScreen extends StatefulWidget {
  final Note note;
  EditNoteHomeScreen(this.note);

  @override
  State<EditNoteHomeScreen> createState() => _EditNoteHomeScreenState();
}

class _EditNoteHomeScreenState extends State<EditNoteHomeScreen> {
  late final TextEditingController title;
  late final TextEditingController description;
  late final TextEditingController price;

  @override
  void initState() {
    title = TextEditingController(text: widget.note.title);
    description = TextEditingController(text: widget.note.description);
    price = TextEditingController(text: widget.note.price.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: title,
              decoration: InputDecoration(
                  hintText: "Title",
                  fillColor: Colors.white54
              ),
            ),
            SizedBox(height: 15),
            TextFormField(
              inputFormatters: <TextInputFormatter>[
                CurrencyTextInputFormatter(
                    locale: 'vi',
                    symbol: ""
                ),
              ],
              keyboardType: TextInputType.number,
              controller: price,
              decoration: InputDecoration(
                  hintText: "Price",
                  fillColor: Colors.white54
              ),
            ),
            SizedBox(height: 15),
            TextFormField(
              controller: description,
              decoration: InputDecoration(
                  hintText: "Description",
                  fillColor: Colors.white54
              ),
            ),
            BlocListener<EditNoteBloc, EditNoteState>(
              listener: (context, state){
                final formStatus = state.formStatus;
                if (formStatus == FormEditStatus.SubmissionSuccess) {
                  Navigator.pop(context);
                }
              },
              child: BlocBuilder<EditNoteBloc, EditNoteState>(
                builder: (context, state){
                  if(state.formStatus == FormEditStatus.FormSubmitting){
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  else if(state.formStatus == FormEditStatus.SubmissionSuccess){}
                  else if(state.formStatus == FormEditStatus.SubmissionFailed){
                    return Center(
                      child: Icon(Icons.warning, color: Colors.red),
                    );
                  }
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: InkWell(
                        customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        onTap: (){
                          context.read<EditNoteBloc>().add(
                              EditNoteSubmitted(
                                  widget.note.id!,
                                  title.text,
                                  description.text,
                                  Utils.reformatMoneyInput(price.text),
                                  widget.note.type!,
                                  widget.note.createAt!,
                              )
                          );
                        },
                        child: Ink(
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: Colors.deepPurpleAccent
                          ),
                          child: Text(
                            "Confirm",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

