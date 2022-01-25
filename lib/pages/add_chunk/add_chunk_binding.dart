import 'package:get/get.dart';

import 'add_chunk_logic.dart';

class AddChunkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddChunkLogic());
  }
}
