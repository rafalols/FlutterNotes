import 'package:Notes/database/moordatabase.dart';
import 'package:Notes/screens/add_note_page.dart';
import 'package:Notes/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => MyDatabase(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          backgroundColor: Colors.black,
          primarySwatch: Colors.amber,
        ),
        routes: {
          '/': (context) => GridPage(title: 'Color notes'),
          '/addNote': (context) => AddNotePage(),
        },
      ),
    );
  }
}


