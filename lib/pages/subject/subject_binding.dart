import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import 'subject_logic.dart';

class SubjectBinding extends Bindings {
  @override
  void dependencies() {
    // At lest we should be albe to get .. arguments here .. i guess
    debugPrint('arguments: ${Get.arguments}');
    Get.lazyPut(() => SubjectLogic());
  }
}
