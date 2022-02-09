import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:trainer/models/models.dart';

class ResolveConflictState {
  List<Conflict> conflicts = [
    ChunkBoxNameConflict(
      chunkBoxName: 'Test',
      conflictChunkBoxName: 'Test',
    ),
    ChunkBoxNameConflict(
      chunkBoxName: 'Test',
      conflictChunkBoxName: 'Test',
    ),
    ChunkBoxNameConflict(
      chunkBoxName: 'Test',
      conflictChunkBoxName: 'Test',
    ),
    ChunkBoxNameConflict(
      chunkBoxName: 'Test',
      conflictChunkBoxName: 'Test',
    ),
    ChunkBoxNameConflict(
      chunkBoxName: 'Test',
      conflictChunkBoxName: 'Test',
    ),
  ];
}

abstract class Conflict {
  final RxBool _isSolved = false.obs;

  bool get isSolved => _isSolved.value;

  /// Call this function to solve the conflict.
  ///
  /// Possibly producing another conflict. The conflict is solved
  /// if this function returns null.
  Future<Conflict?> solve(dynamic arguments) async {
    final result = await solveImpl(arguments);
    _isSolved.value = result == null;
    return result;
  }

  @protected
  Future<Conflict?> solveImpl(dynamic arguments);
}

class SubjectIdConflict extends Conflict {
  SubjectIdConflict({required this.subject, required this.conflictSubject});

  final Subject subject;
  final Subject conflictSubject;

  @override
  Future<Conflict?> solveImpl(dynamic arguments) async {
    return null;
  }
}

class ChunkIdConflict extends Conflict {
  ChunkIdConflict({required this.chunk, required this.conflictChunk});

  final Chunk chunk;
  final Chunk conflictChunk;

  @override
  Future<Conflict?> solveImpl(arguments) async {
    return null;
  }
}

class ChunkBoxNameConflict extends Conflict {
  ChunkBoxNameConflict(
      {required this.chunkBoxName, required this.conflictChunkBoxName});

  final String chunkBoxName;
  final String conflictChunkBoxName;

  @override
  Future<Conflict?> solveImpl(arguments) async {
    return null;
  }
}
