import 'package:get/get.dart';
import 'package:trainer/models/models.dart';

import 'subject_state.dart';

class SubjectLogic extends GetxController {
  final SubjectState state = SubjectState();

  Future<void> addChunk(String name, String ref) async {
    final chunk = Chunk.minimal(
      name: name,
      ref: ref,
      subjectId: state.subject.id,
    );
    chunk.save();
  }

  Future<void> updateChunk(Chunk chunk, String name, String ref) async {
    chunk.name = name;
    chunk.ref = ref;
    await chunk.save();
  }

  Future<void> success(Chunk chunk, String memo) async {
    await _addAttempt(chunk, memo, true);
  }

  Future<void> fail(Chunk chunk, String memo) async {
    await _addAttempt(chunk, memo, false);
  }

  Future<void> _addAttempt(Chunk chunk, String memo, bool success) async {
    chunk.points += success ? 100 : -100;
    chunk.points = chunk.points < 0
        ? 0
        : chunk.points > 2000
            ? 2000
            : chunk.points;
    await chunk.save();

    final attempt = Attempt.minimal(
      memo: memo,
      success: false,
      chunkKey: chunk.key,
    );
    await attempt.save();
  }

  Future<void> _closeBox() async {
    await state.chunkBox.close();
  }

  @override
  Future<void> onClose() async {
    // todo this is slow
    await _closeBox();
    super.onClose();
  }
}
