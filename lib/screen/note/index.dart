import 'package:bloc_demo/model/note_model/note.dart';
import 'package:bloc_demo/repository/note_repository.dart';
import 'package:bloc_demo/screen/add_note/index.dart';
import 'package:bloc_demo/screen/edit_note/index.dart';
import 'package:bloc_demo/screen/note/note_bloc/note_event.dart';
import 'package:bloc_demo/screen/note/note_bloc/note_state.dart';
import 'package:bloc_demo/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';
import 'note_bloc/note_bloc.dart';

class NoteScreen extends StatefulWidget {
  NoteScreen({Key? key}) : super(key: key);

  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NoteBloc()..add(GetNoteEvent()),
      child: BlocCoffeeHomeScreen(),
    );
  }
}

class BlocCoffeeHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent.withOpacity(0.9),
      floatingActionButton: SpeedDial(
        child: Icon(Icons.add),
        closedForegroundColor: Colors.black,
        openForegroundColor: Colors.white,
        closedBackgroundColor: Colors.white,
        openBackgroundColor: Colors.black,
        speedDialChildren: <SpeedDialChild>[
          SpeedDialChild(
            child: Icon(Icons.add),
            foregroundColor: Colors.white,
            backgroundColor: Colors.green,
            label: 'Topup',
            onPressed: () async {
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddNoteScreen(type: 0)
                  )
              );
              context.read<NoteBloc>().add(GetNoteEvent());
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.money_off),
            foregroundColor: Colors.white,
            backgroundColor: Colors.red,
            label: 'Add expense',
            onPressed: () async {
               await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddNoteScreen(type: 1)
                  )
              );
              context.read<NoteBloc>().add(GetNoteEvent());
            },
          ),
        ],
      ),
      body: BlocBuilder<NoteBloc, NoteState>(
        builder: (context, state){
          if (state is LoadNoteSuccess){
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: MediaQuery.of(context).size.height*0.1,
                    bottom: 20
                  ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.account_balance_wallet, color: Colors.white70),
                              SizedBox(width: 10),
                              Text(
                                "${Utils.currencyFormat(state.balance-state.used)}",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            children: [
                              Icon(Icons.money_off_sharp, color: Colors.orange),
                              SizedBox(width: 10),
                              Text(
                                "${Utils.currencyFormat(state.used)}",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Spacer(),
                      Icon(Icons.person_pin, color: Colors.white, size: 50),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0),
                          blurRadius: 5.0,
                        ),
                      ],
                    ),
                    child: state.notes.length>0?
                    ListView.builder(
                        itemCount: state.notes.length,
                        itemBuilder: (context, index){
                          Note note = state.notes[index];
                          return Material(
                            child: Padding(
                              padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                              child: InkWell(
                                onTap: (){},
                                onLongPress: (){
                                  showCupertinoModalPopup<void>(
                                    context: context,
                                    builder: (_) => CupertinoActionSheet(
                                      actions: <CupertinoActionSheetAction>[
                                        CupertinoActionSheetAction(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.delete_forever, color: Colors.red.withOpacity(0.6)),
                                              SizedBox(width: 10),
                                              Text("Delete this note")
                                            ],
                                          ),
                                          onPressed: () async{
                                            await NotesDatabase.instance.delete(note.id!);
                                            Navigator.pop(context);
                                            context.read<NoteBloc>().add(GetNoteEvent());
                                          },
                                        ),
                                        CupertinoActionSheetAction(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.edit, color: Colors.black.withOpacity(0.8)),
                                              SizedBox(width: 10),
                                              Text("Edit this note")
                                            ],
                                          ),
                                          onPressed: () async {
                                            Navigator.pop(context);
                                            await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => EditNoteScreen(note: note)
                                                )
                                            );
                                            context.read<NoteBloc>().add(GetNoteEvent());
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                customBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                splashColor: Colors.black45.withOpacity(0.1),
                                child: Ink(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: note.type == 1? Color(0xFFE7CDB0): Color(0xFFC9E2C9),
                                      borderRadius: BorderRadius.circular(12)
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.monetization_on,
                                              color: note.type == 1?Colors.red:Colors.green),
                                          SizedBox(width: 15),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: Text("${note.title}",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 20,
                                                            fontWeight: FontWeight.w600
                                                        ),
                                                        maxLines: 2,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                        note.type==1?
                                                        "- ${Utils.currencyFormat(note.price!)}":
                                                        "+ ${Utils.currencyFormat(note.price!)}",
                                                        style: TextStyle(
                                                            color: Color(0xFFD06314),
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: 15
                                                        ),
                                                        textAlign: TextAlign.end,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 10),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: Text("${note.description}",
                                                        style: TextStyle(
                                                            color: Color(0xFFADA6A6),
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w600
                                                        ),
                                                        maxLines: 2,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Text("${Utils.dateTimeFromMillisecond(note.createAt!)}",
                                                        style: TextStyle(
                                                            color: Color(0xFFADA6A6),
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: 15
                                                        ),
                                                        textAlign: TextAlign.end,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                    ):
                        Center(
                          child: Text("Nothing here, add some transaction? ",
                            style: TextStyle(
                              color: Colors.deepPurpleAccent,
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        )
                  ),
                ),
              ],
            );
          }
          else if (state is LoadFailed){
            return Center(
              child: Text(state.message),
            );
          }
          return Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}

