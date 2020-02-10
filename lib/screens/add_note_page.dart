import 'dart:async';

import 'package:Notes/database/moordatabase.dart';
import 'package:Notes/model/note_data.dart';
import 'package:Notes/widgets/note_text_view.dart';
import 'package:Notes/widgets/title_text_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddNotePage extends StatelessWidget {
  static const routeName = '/addNotes';

  @override
  Widget build(BuildContext context) {
    final NoteData note = ModalRoute.of(context).settings.arguments;
    return AddNote(note);
  }
}

class AddNote extends StatefulWidget {
  final NoteData _note;

  AddNote(this._note);

  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  Color color;
  final titleController = TextEditingController();
  final noteController = TextEditingController();
  Timer _timer;
  var buttonsOpacity = 0.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _timer = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        buttonsOpacity = 1.0;
      });
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    noteController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<MyDatabase>(context);
    titleController.text = widget._note.title;
    noteController.text = widget._note.note;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Stack(children: [
            Hero(
              tag: "heroContainer:${widget._note.id}",
              child: AnimatedContainer(
                decoration: BoxDecoration(
                  color: color ?? widget._note.color,
                  borderRadius: BorderRadius.circular(16.0)
                ),
              duration: Duration(milliseconds: 300),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      TitleTextView(titleController),
                      Expanded(child: NoteTextView(noteController)),
                      AnimatedOpacity(
                        duration: Duration(seconds: 1),
                        opacity: buttonsOpacity,
                        child: Row(
                          children: <Widget>[
                            FlatButton(
                              child: Text("Color"),
                              textColor: Colors.white70,
                              onPressed: () {
                                _changeColor();
                              },
                            ),
                            Expanded(
                              child: RaisedButton(
                                onPressed: () {
                                  _updateNote(database, context);
                                },
                                color: Theme
                                    .of(context)
                                    .accentColor,
                                child: Text("Save"),
                              ),
                            ),
                            FlatButton(
                                child: Text("Delete"),
                                textColor: Colors.white70,
                                onPressed: () {
                                  _deleteNote(database, context);
                                }),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  void _updateNote(MyDatabase database, BuildContext context) {
    final Color colorToUpdate = color ?? widget._note.color;
    database.updateNote(widget._note.toEntity().copyWith(
        title: titleController.text,
        note: noteController.text,
        color: NoteData.colorMap.indexOf(colorToUpdate)));
    Navigator.pop(context);
  }

  void _deleteNote(MyDatabase database, BuildContext context) {
    database.deleteNote(widget._note.toEntity());
    Navigator.pop(context);
  }

  void _changeColor() {
    setState(() {
      int colorId = NoteData.colorMap.indexOf(color ?? widget._note.color) + 1;
      if (colorId == NoteData.colorMap.length) colorId = 0;
      color = NoteData.colorMap[colorId];
    });
  }
}
