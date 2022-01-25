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
    chunk.content = name;
    chunk.ref = ref;
    await chunk.save();
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
