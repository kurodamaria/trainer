import 'package:get/get.dart';

import 'subjects_logic.dart';

class SubjectsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SubjectsLogic());
  }
}
