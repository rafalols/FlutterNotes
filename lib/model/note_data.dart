import 'package:Notes/database/moordatabase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoteData {
  int id;
  String title;
  String note;
  Color color;

  NoteData(this.id) {
    color = Color(0xFF111111);
  }

  NoteData.fromEntity(NoteEntity entity) {
    id = entity.id;
    title = entity.title;
    note = entity.note;
    if (entity.color != null) {
      color = colorMap[entity.color];
    } else {
      color = colorMap[0];
    }
  }

  NoteEntity toEntity() =>
      NoteEntity(
          id: id,
          title: title,
          note: note,
          color: colorMap.indexOf(color)
      );

  static final List colorMap = [
    Colors.grey[900],
    Colors.grey[850],
    Colors.indigo[900],
    Colors.blue[900],
    Colors.blueGrey[900],
    Colors.cyan[900],
    Colors.green[900],
    Colors.deepPurple[900],
    Colors.red[900],
    Colors.amber[900],
    Colors.brown[900],
    Color(0xFF2E1713),
  ];

}