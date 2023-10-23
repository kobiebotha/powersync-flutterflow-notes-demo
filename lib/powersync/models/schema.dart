import 'package:powersync/powersync.dart';

const schema = Schema(([
  Table('notes', [
    Column.text('id'),
    Column.text('created_at'),
    Column.text('title'),
    Column.text('note'),
    Column.text('image_link'),
  ])
]));
