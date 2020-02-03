import 'package:flutter/material.dart';

class TitleTextView extends StatelessWidget {
  final TextEditingController _controller;

  TitleTextView(this._controller);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: TextField(
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontSize: 20.0),
        maxLength: 30,
        controller: _controller,
        decoration: InputDecoration(
            hintText: 'Enter note title',
            hintStyle: TextStyle(color: Colors.white54, fontSize: 20.0),
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(8.0),
            counterText: ""),
      ),
    );
  }
}
