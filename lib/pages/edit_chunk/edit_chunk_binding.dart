import 'package:get/get.dart';

import 'edit_chunk_logic.dart';

class EditChunkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditChunkLogic());
  }
}
