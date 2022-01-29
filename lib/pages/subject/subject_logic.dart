import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:trainer/models/models.dart';

import 'subject_state.dart';

class SubjectLogic extends GetxController {
  final SubjectState state = SubjectState();

  void switchFilter(int index) {
    state.currentFilterIndex.value = index;
    state.pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInExpo,
    );
  }

  Future<void> addChunk(String name, String ref) async {
    final chunk = Chunk.minimal(
      content: name,
      ref: ref,
      subjectKey: state.subject.id,
    );
    chunk.save();
  }

  Future<void> updateChunk(Chunk chunk, String name, String ref) async {
    chunk.content = name;
    chunk.ref = ref;
    await chunk.save();
  }

  Future<void> markChunk(Chunk chunk, bool value) async {
    chunk.marked = value;
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
