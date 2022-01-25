import 'package:get/get.dart';
import 'package:trainer/models/models.dart';

class PreviewChunkState {
  final Chunk chunk = Get.arguments['chunk'] as Chunk;
  final bool showHints = Get.arguments['showHints'] as bool;
}
