import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:trainer/services/services.dart';

part 'models.g.dart';

@HiveType(typeId: 1)
class Subject extends HiveObject {
  @HiveField(1)
  String name;

  @HiveField(2)
  final DateTime createdAt;

  @HiveField(3)
  final String chunkBoxName;

  @HiveField(4)

  /// id is key, key is id
  final String id;

  Subject({
    required this.name,
    required this.createdAt,
    required this.chunkBoxName,
    required this.id,
  });

  factory Subject.minimal({required String name}) {
    final id = Services.uuid();
    return Subject(
      name: name,
      createdAt: DateTime.now(),
      chunkBoxName: id,
      id: id,
    );
  }

  @override

  /// Delete the subject and it's chunks
  Future<void> delete() async {
    final chunks = await Hive.openBox<Chunk>(chunkBoxName);
    await chunks.deleteFromDisk();
    await super.delete();
  }

  @override

  /// Update or store the subject in box
  Future<void> save() async {
    if (isInBox == false) {
      await Services.persist.subjectsBox.put(id, this);
    } else {
      await super.save();
    }
  }

  Future<Map<String, dynamic>> toJson() async {
    return {
      'id': id,
      'name': name,
      'chunkBoxName': chunkBoxName,
      'createdAt': createdAt.toIso8601String(),
      'chunks': (await Hive.openBox<Chunk>(chunkBoxName)).values.map((e) =>
          e.toJson()).toList()
    };
  }
}

@HiveType(typeId: 2)
class Chunk extends HiveObject {
  @HiveField(1)
  String content;

  @HiveField(2)
  String ref;

  @HiveField(3)
  final DateTime createdAt;

  @HiveField(4)
  final String subjectKey;

  @HiveField(5)

  /// id is key, key is id
  final String id;

  @HiveField(6)
  final String chunkBoxName;

  @HiveField(7)
  String hints;

  @HiveField(8)
  List<String> tags;

  @HiveField(9)
  bool marked;

  Chunk({
    required this.content,
    required this.ref,
    required this.createdAt,
    required this.subjectKey,
    required this.id,
    required this.chunkBoxName,
    required this.hints,
    required this.tags,
    required this.marked,
  });

  factory Chunk.minimal({
    required String content,
    required String ref,
    required String subjectKey,
  }) {
    final id = Services.uuid();
    return Chunk(
      content: content,
      ref: ref,
      createdAt: DateTime.now(),
      subjectKey: subjectKey,
      id: id,
      chunkBoxName: subjectKey,
      hints: '',
      tags: [],
      marked: false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'chunkBoxName': chunkBoxName,
      'hints': hints,
      'tags': tags,
      'createdAt': createdAt.toIso8601String(),
      'marked': marked,
      'content': content,
      'ref': ref,
      'subjectKey': subjectKey,
    };
  }

  @override
  Future<void> delete() async {
    await super.delete();
  }

  @override

  /// Save or update the chunk.
  Future<void> save() async {
    if (isInBox) {
      await super.save();
    } else {
      final box = await Hive.openBox<Chunk>(chunkBoxName);
      await box.put(Services.uuid(), this);
    }
  }
}
