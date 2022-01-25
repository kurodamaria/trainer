import 'package:get/get.dart';
import 'package:trainer/models/models.dart';
import 'package:trainer/pages/subject/subject_logic.dart';

import 'add_chunk_state.dart';

class AddChunkLogic extends GetxController {
  final AddChunkState state = AddChunkState();

  final _chunk = Chunk.minimal(
    name: '',
    ref: '',
    subjectId: Get.find<SubjectLogic>().state.subject.id,
  );

  void _save() {
    _chunk.content = state.content.value;
    _chunk.hints = state.hints.value;
    _chunk.ref = state.ref.value;
  }

  Future<bool> save() async {
    _save();
    await _chunk.save();
    return true;
  }

  // Preview the chunk
  Future<void> confirmSave() async {
    if (canSave() == false) {
      return;
    }
    _save();
    final result = await Get.toNamed('/preview_chunk', arguments: _chunk);
    if (result == true) {
      await save();
      Get.back();
    }
  }

  bool canSave() {
    return state.content.isNotEmpty && state.ref.isNotEmpty;
  }

  void setContent(String value) {
    state.content.value = value;
  }

  void setHints(String value) {
    state.hints.value = value;
  }

  void setRef(String value) {
    state.ref.value = value;
  }
}
