import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

part 'chunker.g.dart';

@DataClassName("Chunk")
class Chunks extends Table {
  IntColumn get id => integer().autoIncrement()();

  RealColumn get effectiveLevel => real().withDefault(const Constant(0.5))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  TextColumn get content => text().nullable()();

  TextColumn get reference => text().withLength(min: 1)();

  BlobColumn get image => blob().nullable()();

  BoolColumn get isMarked => boolean().withDefault(const Constant(false))();

  IntColumn get subject =>
      integer().references(Subjects, #id, onDelete: KeyAction.cascade)();
}

@DataClassName("Subject")
class Subjects extends Table {
  IntColumn get id => integer().autoIncrement()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  TextColumn get name => text().withLength(min: 1)();
}

LazyDatabase _openDatabase(String path) {
  return LazyDatabase(() async {
    // final dbFolder = await getApplicationDocumentsDirectory();
    // final file = File(join(dbFolder.path, 'chunks.sqlite'));
    final file = File(join(path, 'chunks.sqlite'));
    return NativeDatabase(file, logStatements: true);
  });
}

@DriftDatabase(tables: [Subjects, Chunks])
class ChunkerDatabase extends _$ChunkerDatabase {
  ChunkerDatabase(String path) : super(_openDatabase(path));

  @override
  int get schemaVersion => 6;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        beforeOpen: (d) async {
          // Enable foreign key
          await customStatement('PRAGMA foreign_keys = ON');
        },
        onUpgrade: (Migrator m, int from, int to) async {
          if (from < 2) {
            // Migrate constraint: ON DELETE CASCADE
            await m.alterTable(TableMigration(chunks));
          }
          if (from < 4) {
            // Migrate: Add a new image column
            await m.addColumn(chunks, chunks.image);
          }
          if (from < 5) {
            // Migrate: nullable content
            await m.alterTable(TableMigration(chunks));
          }
          if (from < 6) {
            // Migrate: Add a new effectiveLevel column
            await m.addColumn(chunks, chunks.effectiveLevel);
          }
        },
      );

  @override
  StreamQueryUpdateRules get streamUpdateRules => StreamQueryUpdateRules([
        WritePropagation(
            on: TableUpdateQuery.onTable(subjects),
            result: [TableUpdate.onTable(chunks)])
      ]);
}
