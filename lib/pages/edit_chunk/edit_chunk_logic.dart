import 'package:get/get.dart';
import 'package:trainer/app/routes.dart';
import 'package:trainer/models/models.dart';

import 'edit_chunk_state.dart';

class EditChunkLogic extends GetxController {
  final EditChunkState state = EditChunkState();

  void setContent(String content) {
    state.content.value = content;
    state.modified.value = true;
  }

  void setRef(String ref) {
    state.ref.value = ref;
    state.modified.value = true;
  }

  void setHints(String hints) {
    state.hints.value = hints;
    state.modified.value = true;
  }

  void setTags(List<String> tags) {
    state.tags.value = tags;
    state.modified.value = true;
  }

  bool canSave() {
    return state.content.isNotEmpty && state.ref.isNotEmpty;
  }

  Future<bool> preview() async {
    _dumpToChunk(_chunk);
    return await Get.toNamed(Routes.previewChunkPage.name,
        arguments: {'chunk': _chunk, 'showHints': true});
  }

  late final Chunk _chunk;

  EditChunkLogic() {
    _chunk = Chunk(
      hints: state.chunk.hints,
      chunkBoxName: state.chunk.chunkBoxName,
      createdAt: state.chunk.createdAt,
      ref: state.chunk.ref,
      content: state.chunk.content,
      id: state.chunk.id,
      subjectKey: state.chunk.subjectKey,
      tags: state.chunk.tags,
      marked: state.chunk.marked,
    );
  }

  void _dumpToChunk(Chunk chunk) {
    chunk.content = state.content.value;
    chunk.hints = state.hints.value;
    chunk.ref = state.ref.value;
    chunk.tags = state.tags;
  }

  Future<void> save() async {
    _dumpToChunk(state.chunk);
    await state.chunk.save();
  }

  Future<void> previewAndSave() async {
    if (await preview() == true) {
      await save();
      Get.back();
    }
  }
}
