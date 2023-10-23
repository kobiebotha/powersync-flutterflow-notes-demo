import 'package:powersync/sqlite3.dart' as sqlite;
import 'package:logging/logging.dart';
import '../powersync.dart';

final log = Logger('powersync-flutterflow');

class Notes {
  final String id;
  final String created_at;
  final String title;
  final String note;
  final String? image_link;

  Notes({
    required this.id,
    required this.created_at,
    required this.title,
    required this.note,
    this.image_link,
  });

  factory Notes.fromRow(sqlite.Row row) {
    return Notes(
      id: row['id'],
      created_at: row['created_at'],
      title: row['title'],
      note: row['note'],
      image_link: row['image_link'],
    );
  }
  static Future<List<Notes>> getAllNotes() async {
    var allNotes = await db.getAll('SELECT * FROM notes');

    final NotesList = allNotes.map((row) => Notes.fromRow(row)).toList();

    return NotesList;
  }

  static Future<List<Notes>> getNoteById(String? id) async {
    var allNotes = await db.getAll('SELECT * FROM notes WHERE id = ?', [id]);

    final NotesList = allNotes.map((row) => Notes.fromRow(row)).toList();

    return NotesList;
  }

  static Future<void> createNote(
      String title, String note, String? imageLink) async {
    final result = await db.execute(
        'INSERT INTO notes(id, title, note, created_at, image_link) VALUES (uuid(), ?, ?, datetime(), ?)',
        [title, note, imageLink]);
  }
}
