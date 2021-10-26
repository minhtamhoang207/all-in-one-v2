import 'package:bloc_demo/repository/note_repository.dart';
import 'package:bloc_demo/screen/add_note/add_note_bloc/add_note_event.dart';
import 'package:bloc_demo/utils/utils.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'add_note_bloc/add_note_bloc.dart';
import 'add_note_bloc/add_note_state.dart';

class AddNoteScreen extends StatefulWidget {
  final int type;
  AddNoteScreen({Key? key, required this.type}) : super(key: key);

  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  NotesDatabase _notesDatabase = NotesDatabase.instance;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddNoteBloc(noteRepo: _notesDatabase),
      child: AddNoteHomeScreen(widget.type),
    );
  }
}

class AddNoteHomeScreen extends StatelessWidget {
  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController price = TextEditingController();
  final int type;
  AddNoteHomeScreen(this.type);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: type == 1 ? Color(0xFFf5eada) : Color(0xFFebfade),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(type == 1 ? "Add expense" : "Topup"),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: title,
              decoration:
                  InputDecoration(hintText: "Title", fillColor: Colors.white54),
            ),
            SizedBox(height: 15),
            TextField(
              inputFormatters: <TextInputFormatter>[
                CurrencyTextInputFormatter(locale: 'vi', symbol: ""),
              ],
              keyboardType: TextInputType.number,
              controller: price,
              decoration:
                  InputDecoration(hintText: "Price", fillColor: Colors.white54),
            ),
            SizedBox(height: 15),
            TextField(
              controller: description,
              decoration: InputDecoration(
                  hintText: "Description", fillColor: Colors.white54),
            ),
            BlocListener<AddNoteBloc, AddNoteState>(
              listener: (context, state) {
                final formStatus = state.formStatus;
                if (formStatus == FormSubmissionStatus.SubmissionSuccess) {
                  Navigator.pop(context);
                }
              },
              child: BlocBuilder<AddNoteBloc, AddNoteState>(
                builder: (context, state) {
                  if (state.formStatus == FormSubmissionStatus.FormSubmitting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state.formStatus ==
                      FormSubmissionStatus.SubmissionSuccess) {
                  } else if (state.formStatus ==
                      FormSubmissionStatus.SubmissionFailed) {
                    return Center(
                      child: Icon(Icons.warning, color: Colors.red),
                    );
                  }
                  return Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: InkWell(
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      onTap: () {
                        context.read<AddNoteBloc>().add(NoteSubmitted(
                            title.text,
                            description.text,
                            Utils.reformatMoneyInput(price.text),
                            type,
                            DateTime.now().millisecondsSinceEpoch));
                      },
                      child: Ink(
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: Colors.deepPurpleAccent),
                        child: Text(
                          "ADD",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
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
