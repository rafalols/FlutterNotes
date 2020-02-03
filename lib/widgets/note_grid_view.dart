import 'package:Notes/model/note_data.dart';
import 'package:flutter/material.dart';

class NoteGridView extends StatelessWidget {
  final NoteData _note;

  const NoteGridView(this._note);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/addNote", arguments: _note);
      },
      child: Stack(children: [
        Hero(
          tag: 'heroContainer:${_note.id}',
          child: Container(
            constraints: new BoxConstraints.expand(),
            decoration: BoxDecoration(
              color: _note.color,
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Visibility(
                visible: _note.title != null && _note.title.isNotEmpty,
                child: Text(
                  _note.title ?? "No title",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Visibility(
                visible: _note.title != null && _note.title.isNotEmpty,
                child: SizedBox(
                  height: 10.0,
                ),
              ),
              Visibility(
                visible: _note.note != null && _note.note.isNotEmpty,
                child: Text(_note.note ?? "",
                  maxLines: 7,
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
                  )),
              ),
            ],
          ),
        ),
        Visibility(
          visible: (_note.title == null || _note.title.isEmpty)
              && (_note.note == null || _note.note.isEmpty),
          child: Center(
            child: Text(
              "Empty",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white30,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
        )
      ]),
    );
  }
}
