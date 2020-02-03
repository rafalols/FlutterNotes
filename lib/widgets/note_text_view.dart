import 'package:flutter/material.dart';

class NoteTextView extends StatelessWidget {
  final TextEditingController _controller;

  NoteTextView(this._controller);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: TextField(
        style: TextStyle(color: Colors.white70, fontSize: 16.0),
        keyboardType: TextInputType.multiline,
        maxLines: null,
        controller: _controller,
        decoration: InputDecoration(
            hintText: 'Write your note',
            hintStyle: TextStyle(color: Colors.white54, fontSize: 20.0),
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(8.0),
            counterText: ""),
      ),
    );
  }
}
