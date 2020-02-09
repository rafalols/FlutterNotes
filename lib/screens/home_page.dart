import 'package:Notes/database/moordatabase.dart';
import 'package:Notes/model/note_data.dart';
import 'package:Notes/widgets/note_grid_view.dart';
import 'package:Notes/widgets/note_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GridPage extends StatefulWidget {
  GridPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _GridPageState createState() => _GridPageState();
}

class _GridPageState extends State<GridPage> with SingleTickerProviderStateMixin   {
  bool useGrid = true;

  AnimationController menuIconAnimController;

  @override
  void initState() {
    super.initState();
    menuIconAnimController =
        AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final MyDatabase database = Provider.of<MyDatabase>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          GestureDetector(
            onTap: () { _changeLayout(); },
            child: Container(
              padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
              alignment: Alignment.center,
              child: AnimatedIcon(
                icon: AnimatedIcons.list_view,
                progress: menuIconAnimController,
              ),
            ),
          ),
        ],
      ),
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        child: _buildContentWidget(context, database, useGrid),
        transitionBuilder: (widget, animation) {
          return ScaleTransition(
            scale: animation,
            child: widget,
          );
        },
      ),
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

  Widget _buildContentWidget(
      BuildContext context, MyDatabase database, bool useGrid) {
    if (useGrid) {
      return _buildNotesGridStream(context, database);
    } else {
      return _buildNotesListStream(context, database);
    }
  }

  StreamBuilder<List<NoteEntity>> _buildNotesListStream(
      BuildContext context, MyDatabase database) {
    return StreamBuilder(
      key: Key("grid"),
      stream: database.watchAllNotes(),
      initialData: List<NoteEntity>(),
      builder: (context, AsyncSnapshot<List<NoteEntity>> snapshot) {
        if (!snapshot.hasData && snapshot.data.length == 0) {
          return CircularProgressIndicator();
        }
        List<NoteData> notes = snapshot.data
                ?.map((entity) => NoteData.fromEntity(entity))
                ?.toList() ?? [];
        return ListView(
          children: notes.map((note) => NoteListTile(note)).toList(),
        );
      },
    );
  }

  StreamBuilder<List<NoteEntity>> _buildNotesGridStream(
      BuildContext context, MyDatabase database) {
    return StreamBuilder(
      key: Key("list"),
      stream: database.watchAllNotes(),
      initialData: List<NoteEntity>(),
      builder: (context, AsyncSnapshot<List<NoteEntity>> snapshot) {
        if (!snapshot.hasData && snapshot.data.length == 0) {
          return CircularProgressIndicator();
        }
        List<NoteData> notes = snapshot.data
                ?.map((entity) => NoteData.fromEntity(entity))
                ?.toList() ?? [];
        return GridView.count(
            padding: EdgeInsets.all(16.0),
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 16.0,
            children: notes.map((note) => NoteGridView(note)).toList());
      },
    );
  }

  _changeLayout() {
    setState(() {
      useGrid = !useGrid;
      useGrid
          ? menuIconAnimController.reverse()
          : menuIconAnimController.forward();
    });
  }
}
