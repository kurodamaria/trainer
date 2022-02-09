import 'package:get/get.dart';

import 'resolve_conflict_state.dart';

class ResolveConflictLogic extends GetxController {
  final ResolveConflictState state = ResolveConflictState();

  Future<void> solve(int index, dynamic arguments) async {
    await state.conflicts[index].solve(arguments);
  }

  String describeShortly(Conflict conflict) {
    if (conflict is ChunkBoxNameConflict) {
      return 'Conflict of chunk box name';
    } else if (conflict is ChunkIdConflict) {
      return 'Conflict of chunk id';
    } else if (conflict is SubjectIdConflict) {
      return 'Conflict of subject id';
    } else {
      return 'Unknown conflict';
    }
  }

  String describeDetails(Conflict conflict) {
    if (conflict is ChunkBoxNameConflict) {
      return 'The box name [${conflict.chunkBoxName}] is in conflicting with existing [${conflict.conflictChunkBoxName}].';
    } else if (conflict is ChunkIdConflict) {
      return 'The chunk of id [${conflict.chunk.id}] is in conflicting with existing [${conflict.conflictChunk.id}].';
    } else if (conflict is SubjectIdConflict) {
      return 'The subject of id [${conflict.subject.id}] is in conflicting with existing [${conflict.conflictSubject.id}].';
    } else {
      return 'Unknown.';
    }
  }

  String describeSolution(Conflict conflict) {
    if (conflict is ChunkBoxNameConflict) {
      return 'Merge or create another subject.';
    } else if (conflict is ChunkIdConflict) {
      return 'Generate another id.';
    } else if (conflict is SubjectIdConflict) {
      return 'Generate another id.';
    } else {
      return 'Unknown.';
    }
  }
}
