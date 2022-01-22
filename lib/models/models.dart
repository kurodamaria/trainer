import 'package:hive/hive.dart';
import 'package:trainer/services/services.dart';

part 'models.g.dart';

// Access
// Subject <-> Chunk <-> Attempt

// Forward Access
// Subject -> Chunk: HiveList
// Chunk -> Attempt: HiveList

// Reversed Access (You don't need reversed access)
// Chunk -> Subject: subjectBoxName
// Attempt -> Chunk: chunkBoxName, chunkKey

// Modifying
// Add Subject: HiveList.box.add
// Delete Subject: subject.delete
// Modify Subject: HiveList.add

// Add Chunk: HiveList.box.add
// Delete Chunk: chunk.delete
// Modify Chunk: HiveList.add

// Add Attempt: HiveList.box.add
// Delete Attempt: attempt.delete
// Modify Attempt: HiveList.add

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
      await Services.persist.subjectsBox.put(Services.uuid(), this);
    } else {
      await super.save();
    }
  }
}

@HiveType(typeId: 2)
class Chunk extends HiveObject {
  @HiveField(1)
  String name;

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
  final String attemptBoxName;

  @HiveField(7)
  final String chunkBoxName;

  @HiveField(8)
  int points;

  Chunk({
    required this.name,
    required this.ref,
    required this.createdAt,
    required this.subjectKey,
    required this.id,
    required this.attemptBoxName,
    required this.chunkBoxName,
    required this.points,
  });

  factory Chunk.minimal({
    required String name,
    required String ref,
    required String subjectId,
  }) {
    final id = Services.uuid();
    return Chunk(
      name: name,
      ref: ref,
      createdAt: DateTime.now(),
      subjectKey: subjectId,
      id: id,
      attemptBoxName: id,
      chunkBoxName: subjectId,
      points: 200,
    );
  }

  @override
  Future<void> delete() async {
    final attempts = await Hive.openBox<Attempt>(attemptBoxName);
    await attempts.deleteFromDisk();
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

@HiveType(typeId: 3)
class Attempt extends HiveObject {
  @HiveField(1)
  final DateTime createdAt;

  @HiveField(2)
  final bool success;

  @HiveField(3)
  String memo;

  @HiveField(4)
  final String chunkKey;

  @HiveField(5)
  final String chunkBoxName;

  @HiveField(6)
  final String attemptBoxName;

  Attempt({
    required this.createdAt,
    required this.success,
    required this.memo,
    required this.chunkKey,
    required this.chunkBoxName,
    required this.attemptBoxName,
  });

  factory Attempt.minimal({
    required String memo,
    required bool success,
    required String chunkKey,
  }) {
    final id = Services.uuid();
    return Attempt(
      createdAt: DateTime.now(),
      success: success,
      memo: memo,
      chunkKey: chunkKey,
      chunkBoxName: chunkKey,
      attemptBoxName: chunkKey,
    );
  }

  @override
  Future<void> save() async {
    if (isInBox) {
      await super.save();
    } else {
      final box = await Hive.openBox<Attempt>(attemptBoxName);
      await box.put(Services.uuid(), this);
    }
  }
}
