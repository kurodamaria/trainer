import 'package:get/get.dart';

import 'preview_chunk_state.dart';

class PreviewChunkLogic extends GetxController {
  final PreviewChunkState state = PreviewChunkState();

  void doSave() {
    Get.back(result: true);
  }

  void backReedit() {
    Get.back(result: false);
  }
}
