import 'package:get/get.dart';

import 'resolve_conflict_logic.dart';

class ResolveConflictBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ResolveConflictLogic());
  }
}
