import 'package:get/get.dart';
import 'package:trainer/models/models.dart';

class EditChunkState {
  final Chunk chunk = Get.arguments['chunk'] as Chunk;
  final String title = Get.arguments['title'] as String;

  late final RxString content;
  late final RxString ref;
  late final RxString hints;
  late final RxList<String> tags;
  late final RxInt failTimes;

  EditChunkState() {
    content = chunk.content.obs;
    ref = chunk.ref.obs;
    hints = chunk.hints.obs;
    tags = chunk.tags.obs;
    failTimes = chunk.failTimes.obs;
  }
}
