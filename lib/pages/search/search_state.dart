import 'package:get/get.dart';
import 'package:trainer/models/models.dart';

class SearchState {
  /// Data pool for searching
  final List<String> chunkBoxes = Get.arguments['chunkBoxes'] as List<String>;

  /// match test
  final bool Function(Chunk chunk) matcher = Get.arguments['matcher'];

  /// Search Result
  final RxList<Chunk> result = RxList<Chunk>();
}
