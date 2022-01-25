import 'package:get/get.dart';

import 'preview_chunk_logic.dart';

class PreviewChunkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PreviewChunkLogic());
  }
}
