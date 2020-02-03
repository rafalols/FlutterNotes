import 'package:moor_flutter/moor_flutter.dart';

part 'moordatabase.g.dart';

@DataClassName("NoteEntity")
class Notes extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text().withLength(min: 0, max: 30).nullable()();

  TextColumn get note => text().withLength(min: 0, max: 3000).nullable()();

  IntColumn get color => integer().nullable()();
}

@UseMoor(tables: [Notes])
class MyDatabase extends _$MyDatabase {
  MyDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(path: 'db.sqlite'));

  @override
  int get schemaVersion => 1;

  Stream<List<NoteEntity>> watchAllNotes() => (select(notes)).watch();
  Future<int> createNewNote() => into(notes).insert(NoteEntity());
  Future updateNote(NoteEntity note) => update(notes).replace(note);
  Future deleteNote(NoteEntity note) => delete(notes).delete(note);

}
