import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:get/get.dart' hide Value;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trainer/data/provider/chunker.dart';
import 'package:trainer/tools/keys.dart' as keys;

class ChunkRepository {
  final ChunkerDatabase database = ChunkerDatabase(
      Get.find<SharedPreferences>().getString(keys.keyDataFolder)!);

  MultiSelectable<Subject> get allSubjects => database.subjects.select();

  MultiSelectable<Chunk> get allChunks => database.chunks.select();

  MultiSelectable<Chunk> allChunksOfSubject(Subject subject) {
    return database.chunks.select()
      ..where((tbl) => tbl.subject.equals(subject.id));
  }

  MultiSelectable<Chunk> markedChunksOfSubject(Subject subject) {
    return database.chunks.select()..where((tbl) => tbl.isMarked.equals(true));
  }

  MultiSelectable<Chunk> unmarkedChunksOfSubject(Subject subject) {
    return database.chunks.select()..where((tbl) => tbl.isMarked.equals(false));
  }

  Future<int> addSubject(SubjectsCompanion subject) async {
    return await database.into(database.subjects).insert(subject);
  }

  Future<int> addChunk(ChunksCompanion chunk) async {
    return await database.into(database.chunks).insert(chunk);
  }

  Future<bool> updateChunk(Chunk chunk) async {
    return await database.update(database.chunks).replace(chunk);
  }

  Future<int> updateOrInsertChunk(ChunksCompanion companion) async {
    return await database.into(database.chunks).insert(
          companion,
          mode: InsertMode.insertOrReplace,
        );
  }

  Future<int> deleteSubject(Subject subject) async {
    // database
    //     .delete(database.chunks)
    //     .where((tbl) => tbl.subject.equals(subject.id));
    return await database.delete(database.subjects).delete(subject);
  }

  Future<void> deleteAllChunks() async {
    await (database.delete(database.chunks)).go();
  }

  Future<void> importFromHiveData(File file) async {
    final source = await file.readAsString();
    final json = (jsonDecode(source) as List<dynamic>)
        .map((e) => e as Map<String, dynamic>);
    for (final subjectJson in json) {
      final s = SubjectsCompanion(
        name: Value(subjectJson['name']),
        createdAt: Value(DateTime.parse(subjectJson['createdAt'])),
      );
      final id = await addSubject(s);
      await database.batch(
        (batch) => batch.insertAll(
          database.chunks,
          (subjectJson['chunks'] as List<dynamic>).map(
            (e) => ChunksCompanion(
                content: Value(e['content']),
                reference: Value(e['ref']),
                subject: Value(id),
                createdAt: Value(DateTime.parse(e['createdAt']))),
          ),
        ),
      );
    }
  }

  Future<void> deleteChunk(Chunk itemToDelete) async {
    await database.delete(database.chunks).delete(itemToDelete);
  }

  Future<Chunk> chunkOfId(int rowId) async {
    final selection = database.chunks.select()
      ..where((tbl) => tbl.id.equals(rowId));
    return await selection.getSingle();
  }

  /// Export the database file to the [directory]
  Future<void> exportDatabaseFile(Directory directory) async {
    if (await Permission.manageExternalStorage.request().isGranted) {
      final dbFolder = await getApplicationDocumentsDirectory();
      final dbFile = File(join(dbFolder.path, 'chunks.sqlite'));
      final destinationFile = File(join(directory.path, 'chunks.sqlite'));
      await destinationFile.writeAsBytes(await dbFile.readAsBytes());
    }
  }
}
