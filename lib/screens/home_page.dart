import 'package:Notes/database/moordatabase.dart';
import 'package:Notes/model/note_data.dart';
import 'package:Notes/widgets/note_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    final MyDatabase database = Provider.of<MyDatabase>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _buildNotesStream(context, database),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final id = await database.createNewNote();
          Navigator.pushNamed(context, "/addNote", arguments: NoteData(id));
        },
        tooltip: 'Add note',
        child: Icon(Icons.add),
      ),
    );
  }

  StreamBuilder<List<NoteEntity>> _buildNotesStream(BuildContext context, MyDatabase database) {
    return StreamBuilder(
      stream: database.watchAllNotes(),
      initialData: List<NoteEntity>(),
      builder: (context, AsyncSnapshot<List<NoteEntity>> snapshot) {
        if (!snapshot.hasData && snapshot.data.length == 0) {
          return CircularProgressIndicator();
        }
        List<NoteData> notes = snapshot.data?.map((entity) => NoteData.fromEntity(entity))
            ?.toList() ?? [];
        return GridView.count(
          padding: EdgeInsets.all(16.0),
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 16.0,
          children: notes.map((note) => NoteGridView(note)).toList()
        );
      },
    );
  }
}
