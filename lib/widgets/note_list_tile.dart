import 'package:Notes/model/note_data.dart';
import 'package:flutter/material.dart';

class NoteListTile extends StatelessWidget {
  final NoteData _note;

  const NoteListTile(this._note);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/addNote", arguments: _note);
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 0),
        child: Hero(
          tag: 'heroContainer:${_note.id}',
          child: Card(
            color: _note.color ?? NoteData.colorMap[0],
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                    visible: _note.title != null && _note.title.isNotEmpty,
                    child: Text(
                      _note.title ?? "No title",
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
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
